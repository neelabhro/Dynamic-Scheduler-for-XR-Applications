/*
 * Distr_global_greedy_algo.h
 *
 *  Created on: Jul 25, 2015
 *      Author: Sladjana
 */

#ifndef DISTR_GLOBAL_GREEDY_ALGO_H_
#define DISTR_GLOBAL_GREEDY_ALGO_H_
#include <fstream>
#include "../SimResult.h"
#include "../Siminstance.h"
#include <array>
#include <queue>

using namespace std;

class Event_Based_Sim_Results : public SimResult  {
	YAML::Emitter&  doprint(YAML::Emitter& os) const;
public:	
	vector <int> number_of_generated_tasks;
	int total_num_tasks;
	Event_Based_Sim_Results(string name, vector <int> num_gen_tasks, int numb_of_gen_tasks);
	virtual ~Event_Based_Sim_Results();

};

class Event{
public:
	int type;	

	const static int SCHEDULE_NEXT_TASK = 0;
	const static int EVENT_X = 1;
};

class Event_based_sim{
	log4cxx::LoggerPtr my_logger;
	int greedy_decision(int round_robin_old_id);
	
	const Sim_instance & sim_instance;
	int algorithm_id = -1;	
	string algo_name;
	

public:
	
	Event_based_sim(const Sim_instance &);
	Event_Based_Sim_Results * run();
	virtual ~Event_based_sim();

	int getAlgorithmId() const {
		return algorithm_id;
	}

	void setAlgorithmId(int algorithmId) {
		algorithm_id = algorithmId;
		switch (algorithm_id){
		case ALGO_ID_GREEDY:
			algo_name = ALGO_NAME_GREEDY;
			my_logger = log4cxx::Logger::getLogger(ALGO_NAME_GREEDY);
			break;
		case ALGO_ID_X:
			//TODO update for the new algorithms
			algo_name = ALGO_NAME_X;
			my_logger = log4cxx::Logger::getLogger(ALGO_NAME_X);
			break;
		default:
			LOG4CXX_ERROR(my_logger,"Queuing selection algorithm not defined!");
		}
		my_logger->setLevel(log4cxx::Level::getInfo());
	}



	//void setTransmissionqueue(bool transmission_queue_in) {
	//	transmission_queue = transmission_queue_in;
	//}

	const static string ALGO_NAME_GREEDY;
	const static string ALGO_NAME_X;
	//TODO update for the ther agorithms

	const static int ALGO_ID_GREEDY=0;
	const static int ALGO_ID_X=1;
	//TODO update for the ther agorithms
};




Event_Based_Sim_Results * global_greedy(const Sim_instance &);


#endif /* DISTR_GLOBAL_GREEDY_ALGO_H_ */
