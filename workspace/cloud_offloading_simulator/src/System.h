/*
 * System.h
 *
 *  Created on: Jan 17, 2017
 *      Author: Sladjana
 */

#ifndef SYSTEM_H_
#define SYSTEM_H_

#include <yaml-cpp/yaml.h>
#include <string>
#include "tools/Tools.h"
#include "log4cxx/logger.h"
#include <boost/serialization/access.hpp>

using namespace std;
using namespace log4cxx;


class Task {
public:
	int origin_id;
	double task_generated;
	

	friend YAML::Emitter& operator << (YAML::Emitter& out, const Task& a){
		out << YAML::BeginMap;
		out << YAML::Key <<"o"<< YAML::Value << a.origin_id;		
		//out << YAML::Key << "task_generated" << YAML::Value << a.task_generated;
		
		out << YAML::EndMap;
		return out;
	}


	/*For serialization*/
	friend class boost::serialization::access;
	template<class Archive>
	void serialize(Archive & ar, const unsigned int version){
		// Simply list all the fields to be serialized/deserialized.
		ar & origin_id;
	};



};

class Stats_on_arrivals {


public:
	map<double, vector <vector<double> > > stats;

	friend YAML::Emitter& operator << (YAML::Emitter& out, const Stats_on_arrivals& a){
		out << YAML::BeginSeq;

		for (auto stats_instant : a.stats){
			out << YAML::BeginMap;
			out << YAML::Key << "time" << YAML::Value << stats_instant.first;
			out << YAML::Key << "stats" << YAML::Value << YAML::Flow << stats_instant.second;
			out << YAML::EndMap;
		}
		return out;
	};

	//For each estimation instant, it returns a matrix of NxM elements, where N is the number of MUs and M is the
	//number of statistics we need to compute: arrival_intensity, avg_size, avg_complexity, so M=3
	static map<double, vector <vector<double> > > compute_statistics_on_arrival(map <double, Task> g_arrival_events,int n_Mus, double time_interval);

};


class System {
	static log4cxx::LoggerPtr logger;







	//initialization functions
	void init_lambdas(YAML::Node config);
	
	
	friend std::ostream& operator<<(std::ostream&, const System&);
	friend YAML::Emitter& operator << (YAML::Emitter& out, const System&);

public:

	//N number of MUs
	int N;
	
	//slot length
	double slot_length;
	
	//task arrival rates at the MU
	vector <double> lambda_i;

	
	int initialized_from;
	static const int INIT_FROM_DESCRIPTION=1;
	
	System(int init_how,YAML::Node config);
	System();
	virtual ~System();



};
#endif /* SYSTEM_H_ */
