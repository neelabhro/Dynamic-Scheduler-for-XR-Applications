/*
 * Distr_global_greedy_algo.cpp
 *
 *  Created on: Jul 25, 2015
 *      Author: Sladjana
 */

#include "Global_greedy_algo.h"

const string Event_based_sim::ALGO_NAME_GREEDY = "Global_greedy";
const string Event_based_sim::ALGO_NAME_X = "Algorithm_x";
//TODO update for the other algorithms


Event_Based_Sim_Results * global_greedy(const Sim_instance &sim_instance){
	Event_based_sim algo(sim_instance);

	return algo.run();
}





YAML::Emitter&  Event_Based_Sim_Results::doprint(YAML::Emitter& out) const {

	out << YAML::Key <<"number_of_generated_tasks" << YAML::Value << YAML::Flow << number_of_generated_tasks;	
	out << YAML::Key <<"total_number_of_tasks" << YAML::Value << YAML::Flow << total_num_tasks;
	//TODO update for the other results that need to be saved
	return out;
}



Event_Based_Sim_Results::Event_Based_Sim_Results(string name, vector<int> num_gen_tasks, int total_gen_tasks):SimResult(name) {
	number_of_generated_tasks = num_gen_tasks;
	total_num_tasks = total_gen_tasks;
	//TODO update for the other results that need to be saved
}

Event_Based_Sim_Results::~Event_Based_Sim_Results() {
}



Event_based_sim::Event_based_sim(const Sim_instance & s_instance): sim_instance(s_instance){
	//set logging level
	my_logger = log4cxx::Logger::getLogger("Event_based");

}

Event_based_sim::~Event_based_sim() {
}

Event_Based_Sim_Results * Event_based_sim::run() {	

	//create transmission queues
	vector <queue <Task> > t_queues (sim_instance.system.N, queue <Task> ());//

	//create event structures
	multimap <double, Event> pending_events;
	pending_events.insert(pair<double,Event> (DBL_MAX,Event()));

	multimap <double, Task> g_arrival_events = sim_instance.g_arrival_events;
	g_arrival_events.insert(pair <double,Task> (DBL_MAX,Task()));


	//results	
	vector <int> number_of_generated_tasks (sim_instance.system.N,0);
	int total_number_of_generated_tasks = 0;

	//info for GREEDY	
	int round_robin_old_id = 0;

	//info for other algorithms
	//TODO update the other algorithms specific info if needed


	while(g_arrival_events.size() > 1 || pending_events.size() > 1){
		auto np = pending_events.begin();

		auto na = g_arrival_events.begin();


		//there are more events to consume


		if (na->first > np->first){
			// pending event is first

			Event pe = np->second;
			double now = np->first;
			//1. remove event from pending
			pending_events.erase(np);

			//2. process pending event

			switch (pe.type){

			case Event::SCHEDULE_NEXT_TASK:
			
			int queue_id;
			switch (algorithm_id){
			case ALGO_ID_GREEDY:
			{
				queue_id = greedy_decision(round_robin_old_id);
					
				double ts = now + sim_instance.system.slot_length;

						
				if(!t_queues[queue_id].empty()){
					t_queues[queue_id].pop();
						
				} else {
					if(VERBOSE){
					cout<<"Nothing to schedule"<<endl;
					}					
				}	
				
				bool t_queues_not_empty = false;

				for (int i=0 ; i < sim_instance.system.N ; i++){
					t_queues_not_empty =  t_queues_not_empty || !t_queues[i].empty();
				}

				if(g_arrival_events.size() > 1 || (g_arrival_events.size() == 1 && t_queues_not_empty)){
					Event schedule_next_task;
					schedule_next_task.type = Event::SCHEDULE_NEXT_TASK;

					pending_events.insert(pair<double,Event>(ts,schedule_next_task));
				}else{
					cout<<"Last task scheduled!"<<endl;
				}



				round_robin_old_id = queue_id;
						
				break;
			}
			case ALGO_ID_X:			
				{
					//TODO implement the other algorithms
					break;

				}

			
			}

				break;

			case Event::EVENT_X:
				
				//TODO implement the other events if any, e.g., flushing the queues after deadlines expire
				break;

			}


		}
		else{
			//arrival is next
			Task pa = na->second;
			double now = na->first;

			//1. remove event from pending
			g_arrival_events.erase(na);

			//2. process arrival
			number_of_generated_tasks[pa.origin_id] += 1;
			total_number_of_generated_tasks += 1;

			//printing useful info
			stringstream s_log;
			s_log << "Arrival (" << pa.origin_id << ";";		

						
			t_queues[pa.origin_id].push(pa);			

			
			if(total_number_of_generated_tasks == 1){				
				Event schedule_next_task;				
				schedule_next_task.type = Event::SCHEDULE_NEXT_TASK;	
				pending_events.insert(pair<double,Event>(now,schedule_next_task));
				
				switch (algorithm_id){
				case ALGO_ID_GREEDY:
					round_robin_old_id = (pa.origin_id - 1) % sim_instance.system.N;
					break;
				case ALGO_ID_X:			
					//TODO implement the other algorithms
					break;

			
			
				}		

				
			}
			
		}
	}

	
	//TODO post-process the save output results if needed


	//print some stats for the results
	LOG4CXX_INFO(my_logger,"Total number of generated tasks" << total_number_of_generated_tasks);




	Event_Based_Sim_Results * s_results = new Event_Based_Sim_Results(algo_name, number_of_generated_tasks, total_number_of_generated_tasks);
	return s_results;

}

int Event_based_sim::greedy_decision(int round_robin_old_id) {
	int queue_id = (round_robin_old_id + 1) % sim_instance.system.N;
	return queue_id;
}



