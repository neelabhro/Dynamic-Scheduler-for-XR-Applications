/*
 * arrival.cpp
 *
 *  Created on: Feb 4, 2016
 *      Author: valentino
 */

#include "arrival.h"

multimap <double , int > generate_poisson_events(double lambda, double sim_time, int type, default_random_engine & generator){

	exponential_distribution<double> exp_updates(lambda);
	multimap <double , int > events;

	double reached_time = 0.0;
	while (reached_time < sim_time){
		double inter_arr = exp_updates(generator);
		reached_time+=inter_arr;
		//cout<<"reached time: "<<reached_time<<endl;
		if(reached_time<sim_time)
			events.insert(pair<double,int>(reached_time,type));
	}
	return events;
}

map <double , int > generate_gammak_events(double lambda, double k, double sim_time, int type, default_random_engine & generator){

	gamma_distribution<double> gamma_updates(k,1.0/lambda);
	map <double , int > events;

	double reached_time = 0.0;
	while (reached_time < sim_time){
		double inter_arr = gamma_updates(generator);
		reached_time+=inter_arr;
		if(reached_time<sim_time)
			events.insert(pair<double,int>(reached_time,type));
	}

	return events;
}

map <double , int > generate_hyperexp_events(vector <double> phase_prob, vector <double> rates, double sim_time, int type, default_random_engine & generator){


	uniform_real_distribution<double> distribution(0.0, 1.0);

	vector<exponential_distribution<double>> exp_updates;

	for (auto rate : rates){

		exponential_distribution<double> exp_dist(rate);
		exp_updates.push_back(exp_dist);
	}

	//if phase_prob is empty, the exponentials are equiprobable
	if(phase_prob.size()==0){
		phase_prob.resize(rates.size(),1.0/rates.size());
	}




	//generate vector for extraction
	vector <double> cum_prob;
	double cumulative = 0;
//	cout << "Phase probs: ";
	for (auto phase : phase_prob){
		cumulative += phase;
//		cout << phase<< " ";
		cum_prob.push_back(cumulative);
	}
//	cout << endl << "Cumul: ";
//	for (auto cp : cum_prob){
//		cout << cp << " ";
//	}
//	cout << endl;


	map <double , int > events;

	double reached_time = 0.0;
	while (reached_time < sim_time){

		//Fist select the exponential distribution to sample from (with prob phase_prob)
		int exp_id = 0;

		double extracted = distribution(generator);

		auto cum_pos = cum_prob.begin();
		while(extracted > (*cum_pos)){
			cum_pos++;
		}
		exp_id = cum_pos - cum_prob.begin();

		//Then sample from that distribution
		double inter_arr = exp_updates[exp_id](generator);
		reached_time+=inter_arr;
		if(reached_time<sim_time)
			events.insert(pair<double,int>(reached_time,type));
	}

	return events;
}
