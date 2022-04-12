/*
 * Siminstance.cpp
 *
 *  Created on: Jul 6, 2015
 *      Author: Sladjana
 */

#include "Siminstance.h"

LoggerPtr Sim_instance::logger(Logger::getLogger("Sim_instance"));


const string log_format(const char *fmt, ...)
{
	va_list va;
	static char formatted[1024];
	va_start(va, fmt);
	vsnprintf(formatted, 1024, fmt, va);
	va_end(va);
	return string(formatted);
}

Sim_instance::Sim_instance(YAML::Node config) {

	algorithms = config["Algorithms"];

	sim_time=config["sim_time"].as<float>();

	
	//this should be used to initialize N and all the containers

	//check whether yaml is new or old format
	if (config["Log_file_path"])
		log_path = config["Log_file_path"].as<string>();
	else
		LOG4CXX_DEBUG(logger, "No log file specified.") ;

	if (config["System_path"])
		sys_path = config["System_path"].as<string>();
	else
		LOG4CXX_DEBUG(logger, "No system file specified.") ;

	if (config["Arrival_process_path"])
		arrival_path = config["Arrival_process_path"].as<string>();
	else
		LOG4CXX_DEBUG(logger, "No arrival file specified.") ;


	
		//if yaml contains "sys_description"
		//then sample all the parameters and generate a System object
		if (config["sys_description"]){

			system = System(System::INIT_FROM_DESCRIPTION,config["sys_description"]);

		}else{

		//TODO 
	}



	//Check if an arrival process is specified, if yes, load it, if not run generate_tasks()
	//So, if the path is not specified or the file does not exist yet
	if(arrival_path.empty() || !ifstream(arrival_path.c_str()).good()){
		generate_tasks();

		if(! arrival_path.empty()){
			cout << "Arrival path isn't empty!";
			ofstream output_file_arrival;
			output_file_arrival.open(arrival_path);
			boost::archive::binary_oarchive oarch(output_file_arrival);
			oarch << g_arrival_events;
			output_file_arrival.close();
		}
	}
	else{
		//load the arrivals
		ifstream input_file_arrival;
		input_file_arrival.open(arrival_path);
		boost::archive::binary_iarchive iarch(input_file_arrival);
		iarch >> g_arrival_events;
		input_file_arrival.close();

	}




}








Sim_instance::~Sim_instance() {
	// TODO Auto-generated destructor stub
}




std::ostream& operator<<(std::ostream &strm, const Sim_instance &a) {
	strm << "Instance of simulation:"<<endl;
	strm <<"sim_time"<< a.sim_time;
	strm <<"\tN= " << a.system.N << endl;
	return  strm;
}

YAML::Emitter& operator << (YAML::Emitter& out, const Sim_instance& a) {
	out << YAML::Key <<"system"<< YAML::Value << a.system;
	out << YAML::Key <<"sim_time"<< YAML::Value << a.sim_time;
	
	if(!a.log_path.empty()){
		out << YAML::Key <<"Log_file_path"<< YAML::Value << a.log_path;
	}
	if(!a.sys_path.empty()){
		out << YAML::Key <<"System_path"<< YAML::Value << a.sys_path;
	}
	if(!a.arrival_path.empty()){
		out << YAML::Key <<"Arrival_process_path"<< YAML::Value << a.arrival_path;
	}
	return out;
}


Task Sim_instance::get_next_task(int mu, double tsg, default_random_engine & generator) {
	/*
	 * vector <double> generated;
	double mult_factor=a-b;
	for (int i = 0 ; i < size; i++){
			generated.push_back(((double)rand()*mult_factor)+a);
	}
	return generated;
	 */
	Task task;
	task.origin_id = mu;	
	task.task_generated=tsg;

	
	return task;
}

void Sim_instance::generate_tasks() {
	g_arrival_events.clear();


	for(int i = 0; i < system.N; i++){
		multimap <double, int > events;
		events = generate_poisson_events(system.lambda_i[i],sim_time, 0 , generator);
		for (auto event : events){
			//Task task = get_next_task(i);
			Task task = get_next_task(i,event.first, generator);
			g_arrival_events.insert( pair <double, Task> (event.first, task));
		}

	}
}





