#include "Process.h"

Process::Process(int id, int arrivalTime, int burstTime, int priority) {
    this->id = id;
    this->arrivalTime = arrivalTime;
    this->burstTime = burstTime;
    this->priority = priority;
    
    // Automatically set these so you don't have to pass them in main
    this->remainingTime = burstTime; 
    this->waitingTime = 0;
    this->turnaroundTime = 0;
    this->completionTime = 0;
}