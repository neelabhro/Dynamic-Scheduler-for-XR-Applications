/*
 * Tools.cpp
 *
 *  Created on: Jan 17, 2017
 *      Author: valentino
 */

#include "Tools.h"

Tools::Tools() {
	// TODO Auto-generated constructor stub

}

vector<double> Tools::parse_yaml_double_vector(YAML::Node node,log4cxx::LoggerPtr logger) {
	vector <double> result;
	if(node.IsSequence()){
		for (YAML::const_iterator it=node.begin();it!=node.end();++it) {
		   result.push_back(it->as<double>());
		}
	}
	else{
		LOG4CXX_ERROR(logger,"The YAML node is not a sequence!" << node);
		exit(-1);
	}
	return result;

}

vector<vector<double> > Tools::parse_yaml_double_matrix(YAML::Node node,log4cxx::LoggerPtr logger) {
	vector < vector <double> > result;
	if(node.IsSequence()){
		for (YAML::const_iterator it=node.begin();it!=node.end();++it) {
			vector <double> column;
			YAML::Node internal = *it;
			if(internal.IsSequence()){
				for (YAML::const_iterator inter=internal.begin();inter!=internal.end();++inter) {
					column.push_back(inter->as<double>());
				}
			}
			else{
				LOG4CXX_ERROR(logger,"The YAML node is not a sequence!"<< internal);
				exit(-1);
			}
		   result.push_back(column);
		}
	}
	else{
		LOG4CXX_ERROR(logger,"The YAML node is not a sequence!" << node);
		exit(-1);
	}
	return result;

}

Tools::~Tools() {
	// TODO Auto-generated destructor stub
}

vector <double> Tools::generate_uniform_vector(float a, float b, int size){
	vector <double> generated;
	//double mult_factor=a-b;
	double mult_factor=b-a;
	for (int i = 0 ; i < size; i++){
			generated.push_back(((double)rand()/double(RAND_MAX)*mult_factor)+a);
	}
	return generated;
}
