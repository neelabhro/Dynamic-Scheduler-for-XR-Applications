/*
 * Results.h
 *
 *  Created on: Jul 15, 2015
 *      Author: valentino
 */

#ifndef SIMRESULT_H_
#define SIMRESULT_H_
#include <yaml-cpp/yaml.h>
#include <string>

using namespace std;


class SimResult {


	 virtual YAML::Emitter& doprint(YAML::Emitter& out) const{

//			out << YAML::Key <<"number_of_diff_objects" << YAML::Value << final_allocation.diff_objects;
//
//			out << YAML::Key <<"final_costs" << YAML::Value << YAML::Flow << final_allocation.cost;
//
//			out << YAML::Key <<"cost_saving" << YAML::Value << YAML::Flow << final_allocation.global_CS;
//
//			out << YAML::Key <<"cost_empty_alloc" << YAML::Value << YAML::Flow << final_allocation.global_cost_empty_alloc;

//
//			out << YAML::Key <<"redundancy" << YAML::Value << redundancy;
//
//			out << YAML::Key <<"allocation" << YAML::Value << YAML::BeginSeq;

//			out << YAML::Flow << final_allocation.A;

//			out << YAML::EndSeq;

			return out;
	 };

public:
	string name;
	float redundancy;
	SimResult(string nm);
	virtual ~SimResult();

	friend YAML::Emitter& operator << (YAML::Emitter& out, const SimResult& b){
		out << YAML::BeginMap;
		out << YAML::Key <<"name" << YAML::Value << b.name;
		b.doprint(out);
		out << YAML::EndMap;
		return out;
	};
};

#endif /* RESULTS_H_ */
