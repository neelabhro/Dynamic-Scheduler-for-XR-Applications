//============================================================================
// Name        : pr_tree_simulator.cpp
// Author      : Sladjana Josilo
// Version     :
// Copyright   : You copy this stuff and you are doomed
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <ctime>    // For time()
#include <cstdlib>
#include "Siminstance.h"
#include "SimResult.h"
#include "algorithms/Global_greedy_algo.h"
#include <log4cxx/logger.h>
#include <log4cxx/basicconfigurator.h>
#include <log4cxx/helpers/exception.h>
#include <yaml-cpp/yaml.h>




using namespace std;
using namespace log4cxx;
using namespace log4cxx::helpers;

LoggerPtr logger(Logger::getLogger("PR_TREE_SIMULATOR"));




void print_results(const Sim_instance &a, const vector <SimResult *> & res){
	YAML::Emitter out;
	out <<  YAML::BeginMap;
	out << a;
	out << YAML::Key <<"Results"<<YAML::Value << YAML::BeginSeq;
	for(auto r = res.begin(); r!= res.end(); r++)
		out << *(*r);

	out << YAML::EndSeq;
	out << YAML::EndMap;

	if (a.log_path.length()>0){
		ofstream output_file;
		output_file.open(a.log_path);
		output_file<< out.c_str();
		output_file.close();
	}
	else{
		LOG4CXX_INFO(logger,"Log file path not specified, printing here...\n"<<out.c_str());
	}

}


int main(int argc, char *argv[]) {

	int result = EXIT_SUCCESS;

	logger->setLevel(log4cxx::Level::getInfo());


	try
	{
		// Set up a simple configuration that logs on the console.
		BasicConfigurator::configure();

		LOG4CXX_INFO(logger, "Entering application.")

		//cout << argc << endl;
		vector <SimResult *> results;
		if (argc>2){
			srand ( atoi( argv[2])  );

			LOG4CXX_DEBUG(logger, "Creating simulation instance...");
			YAML::Node config = YAML::LoadFile(argv[1]);

			//this parses or create the System class
			Sim_instance sim_instance(config);

			LOG4CXX_DEBUG(logger, "Simulation instance created.");
			//print system if needed (the check must be here not in siminstance)

			if (sim_instance.system.initialized_from == System::INIT_FROM_DESCRIPTION){

				YAML::Emitter out;
				out <<  YAML::BeginMap;
				out << sim_instance;
				if (config["Algorithms"]){
					out << YAML::Key << "Algorithms" << YAML::Value << config["Algorithms"];
				}
				out << YAML::EndMap;

				if (sim_instance.sys_path.length()>0){
					ofstream output_file;
					output_file.open(sim_instance.sys_path);
					output_file << out.c_str();
					output_file.close();
				}
				else{
					LOG4CXX_INFO(logger,"Sys file path not specified, printing here...\n"<<out.c_str());
				}
			}


			if (config["Algorithms"]){
				//TODO checking which Algorithms are going to be run, do algorithm specific check if needed (i.e., if the needed input for each algorithm is provided)

				for(YAML::const_iterator it=config["Algorithms"].begin(); it != config["Algorithms"].end(); ++it){
					string algo_name = (*it)["name"].as<string>();
					LOG4CXX_INFO(logger, "Running "<<algo_name<<"...");

					//not necessary to create one simulator every time
					Event_based_sim simulator (sim_instance);

					if (algo_name.compare(Event_based_sim::ALGO_NAME_GREEDY)==0){
						simulator.setAlgorithmId(Event_based_sim::ALGO_ID_GREEDY);
						
						results.push_back(simulator.run());
						
					}
					else if(algo_name.compare(Event_based_sim::ALGO_NAME_X)==0){
						simulator.setAlgorithmId(Event_based_sim::ALGO_ID_X);
						//TODO implement the code for the other algorithm(s)
					}
				}
			}
			else{
				LOG4CXX_ERROR(logger, "Please specify which algorithms to run");
				exit(-1);
			}

			print_results(sim_instance, results);
		}else{
				//Sim_instance sim_instance4(YAML::LoadFile("tests/temp_conf.yaml"));
			Sim_instance sim_instance4(YAML::LoadFile("tests/conf_bug_testing.yaml"));
			YAML::Node algos = sim_instance4.algorithms;
			Event_based_sim simulator (sim_instance4);
				for(YAML::const_iterator it=algos.begin(); it != algos.end(); ++it){
					string algo_name = (*it)["name"].as<string>();
					LOG4CXX_INFO(logger, "Running "<<algo_name<<"...");
					if (algo_name.compare(Event_based_sim::ALGO_NAME_GREEDY)==0){
							simulator.setAlgorithmId(Event_based_sim::ALGO_ID_GREEDY);
							results.push_back(simulator.run());
							//results.push_back(global_greedy(sim_instance4));
							print_results(sim_instance4, results);
					}
			}
		}
		LOG4CXX_INFO(logger, "Exiting application.")
	}
	catch(Exception&)
	{
		result = EXIT_FAILURE;
	}

	return result;
}
