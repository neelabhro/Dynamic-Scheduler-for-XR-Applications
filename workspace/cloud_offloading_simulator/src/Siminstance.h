/*
 * Siminstance.h
 *
 *  Created on: Jul 6, 2015
 *      Author: valentino
 */

#ifndef SIMINSTANCE_H_
#define SIMINSTANCE_H_


#define VERBOSE false

#include <iostream>
#include <fstream>
#include <string.h>
#include <stdio.h>
#include <stdarg.h>
#include <map>
#include <vector>
#include <list>
#include <set>
#include <algorithm>
#include <math.h>
#include <climits>
#include <yaml-cpp/yaml.h>
#include <string>
#include <array>
#include <boost/graph/graph_traits.hpp>
#include <boost/graph/adjacency_list.hpp>
#include <boost/graph/kruskal_min_spanning_tree.hpp>
#include <random>
#include <execinfo.h>
#include "log4cxx/logger.h"
#include "tools/Tools.h"
#include "arrival.h"
#include "System.h"
#include <cfloat>//Sladjy had to add because of RAND_MAX error!!!
#include <boost/serialization/map.hpp>
#include <boost/archive/binary_iarchive.hpp>
#include <boost/archive/binary_oarchive.hpp>


using namespace std;
using namespace log4cxx;


#define MYLOG_TRACE(logger, fmt, ...) LOG4CXX_TRACE(logger, log_format(fmt, ## __VA_ARGS__))
#define MYLOG_DEBUG(logger, fmt, ...) LOG4CXX_DEBUG(logger, log_format(fmt, ## __VA_ARGS__))
#define MYLOG_INFO(logger, fmt, ...) LOG4CXX_INFO(logger, log_format(fmt, ## __VA_ARGS__))
#define MYLOG_WARN(logger, fmt, ...) LOG4CXX_WARN(logger, log_format(fmt, ## __VA_ARGS__))
#define MYLOG_ERROR(logger, fmt, ...) LOG4CXX_ERROR(logger, log_format(fmt, ## __VA_ARGS__))
#define MYLOG_FATAL(logger, fmt, ...) LOG4CXX_FATAL(logger, log_format(fmt, ## __VA_ARGS__))

const string log_format(const char *fmt, ...);



class Sim_instance {
	static log4cxx::LoggerPtr logger;

	void init_costs(YAML::Node config);


	friend std::ostream& operator<<(std::ostream&, const Sim_instance&);
	friend YAML::Emitter& operator << (YAML::Emitter& out, const Sim_instance&);



public:



	//simulation time
	double sim_time;
	multimap <double, Task> g_arrival_events;

	YAML::Node algorithms;

	System system;

	string log_path,sys_path,arrival_path;

	Sim_instance(YAML::Node config);
	virtual ~Sim_instance();

	default_random_engine generator;

	void generate_tasks();


	Task get_next_task(int mu, double ts, default_random_engine & generator);

};

#endif /* SIMINSTANCE_H_ */
