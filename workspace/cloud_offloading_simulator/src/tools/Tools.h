/*
 * Tools.h
 *
 *  Created on: Jan 17, 2017
 *      Author: valentino
 */

#ifndef TOOLS_H_
#define TOOLS_H_

#include <vector>
#include <random>
#include <yaml-cpp/yaml.h>
#include "log4cxx/logger.h"

using namespace std;

class Tools {
public:
	//Demand generator functions
	static vector <double> generate_uniform_vector(float a, float b, int size);

	static vector <double> parse_yaml_double_vector(YAML::Node node, log4cxx::LoggerPtr logger);

	static vector < vector<double> > parse_yaml_double_matrix(YAML::Node node, log4cxx::LoggerPtr logger);

	Tools();
	virtual ~Tools();
};

#endif /* TOOLS_H_ */
