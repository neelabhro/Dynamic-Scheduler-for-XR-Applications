/*
 * arrival.h
 *
 *  Created on: Feb 4, 2016
 *      Author: valentino
 */

#ifndef ARRIVAL_H_
#define ARRIVAL_H_

#include <map>
#include <random>
#include <vector>
#include <boost/random.hpp>
using namespace std;

multimap <double , int > generate_poisson_events(double lambda, double sim_time, int type, default_random_engine & generator);

map <double , int > generate_gammak_events(double lambda, double k, double sim_time, int type, default_random_engine & generator);

map <double , int > generate_hyperexp_events(vector <double> phase_prob, vector <double> rates, double sim_time, int type, default_random_engine & generator);

#endif /* ARRIVAL_H_ */
