#include "Scheduler.h"
#include <iostream>
using namespace std;

void Scheduler::diplayStats(ProcessList &completedProcesses) {
    Node* current = completedProcesses.getHead();
    int size = completedProcesses.getSize();
    int totalWaitingTime = 0;
    int totalTurnaroundTime = 0;

cout << "\n==================================================================================" << endl;
    cout << "ID\tArrival\tBurst\t| Finish\tWaiting\t\tTurnaround" << endl;
    cout << "----------------------------------------------------------------------------------" << endl;

    while (current != nullptr) {
        cout << "P" << current->data.id << "\t" 
             << current->data.arrivalTime << "\t" 
             << current->data.burstTime << "\t| " 
             << current->data.completionTime << "\t\t"
             << current->data.waitingTime << "\t\t" 
             << current->data.turnaroundTime << endl;

        totalWaitingTime += current->data.waitingTime;
        totalTurnaroundTime += current->data.turnaroundTime;
        current = current->next;
    }
    cout << "--------------------------------------------------------------------------" << endl;

    double AWT = (double)totalWaitingTime / size;
    double ATT = (double)totalTurnaroundTime / size;
    
    cout << "Average Waiting Time:    " << AWT << endl;
    cout << "Average Turnaround Time: " << ATT << endl;
    cout << "==========================================================================" << endl;
}

void Scheduler::runFCFS(ProcessList &masterList) {
   ProcessQueue readyQueue;
   int currentTime = 0;
   int completed = 0;
   Node* currentInMaster = masterList.getHead();
   int total = masterList.getSize();
   ProcessList completedProcesses;

   while(completed < total) {
        // Check Arrival
        while(currentInMaster != nullptr && currentInMaster->data.arrivalTime <= currentTime) {
            readyQueue.enqueue(currentInMaster->data);
            currentInMaster =  currentInMaster->next;

        }

        // Execution
        if(!readyQueue.isEmpty()) {
            Process p = readyQueue.dequeue();

            p.waitingTime = currentTime - p.arrivalTime;
            currentTime += p.burstTime;
            p.completionTime = currentTime;
            p.turnaroundTime = p.waitingTime + p.burstTime;

            completedProcesses.addProcess(p);
            completed++;
        } else {
            // Handel idle CPU state
            if (currentInMaster != nullptr) {
                currentTime = currentInMaster->data.arrivalTime;
            }
        }
   }
   Scheduler::diplayStats(completedProcesses);
}


void Scheduler::runSJF(ProcessList &masterList, bool preemptive) {
    PriorityQueue pq(true);
    int currentTime = 0;
    int completed = 0;
    Node* it = masterList.getHead();
    int total = masterList.getSize();
    ProcessList completedProcesses;


    while (completed<total) {
        while(it != nullptr && it->data.arrivalTime <= currentTime) {
            pq.enqueue(it->data);
            it = it->next;
        }

        if(!pq.isEmpty()) {
            if(preemptive) {
                Process p = pq.dequeue();
                p.remainingTime--;
                currentTime++;
                if(p.remainingTime > 0) pq.enqueue(p);
                if(p.remainingTime == 0)  {
                    p.completionTime = currentTime;
                    p.waitingTime = p.completionTime - p.arrivalTime -p.burstTime;
                    p.turnaroundTime = p.waitingTime + p.burstTime;
                    completed++;
                    completedProcesses.addProcess(p);
                }
            } else {
                Process p = pq.dequeue();
    
                p.waitingTime = currentTime - p.arrivalTime;
                currentTime += p.burstTime;
    
                p.completionTime = currentTime;
                p.turnaroundTime = p.waitingTime + p.burstTime;
    
                completedProcesses.addProcess(p);
                completed++;
            }
        } else {
            if(it != nullptr) {
                currentTime = it->data.arrivalTime;
            }
        }
    }
    Scheduler::diplayStats(completedProcesses);
}

void Scheduler::runPriority(ProcessList &masterList) {
        PriorityQueue pq(false);
    int currentTime = 0;
    int completed = 0;
    Node* it = masterList.getHead();
    int total = masterList.getSize();
    ProcessList completedProcesses;


    while (completed<total) {
        while(it != nullptr && it->data.arrivalTime <= currentTime) {
            pq.enqueue(it->data);
            it = it->next;
        }

        if(!pq.isEmpty()) {
            Process p = pq.dequeue();

            p.waitingTime = currentTime - p.arrivalTime;
            currentTime += p.burstTime;
            p.completionTime = currentTime;
            p.turnaroundTime = p.waitingTime + p.burstTime;

            completedProcesses.addProcess(p);
            completed++;
        } else {
            if(it != nullptr) {
                currentTime = it->data.arrivalTime;
            }
        }
    }
    Scheduler::diplayStats(completedProcesses);
}
