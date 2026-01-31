#include "Process.h"

// Default constructor
Process::Process() {
    id = 0;
    arrivalTime = 0;
    burstTime = 0;
    priority = 0;

    remainingTime = 0;
    waitingTime = 0;
    turnaroundTime = 0;
    completionTime = 0;
}

// Parameterized constructor
Process::Process(int id, int arrivalTime, int burstTime, int priority) {
    this->id = id;
    this->arrivalTime = arrivalTime;
    this->burstTime = burstTime;
    this->priority = priority;

    remainingTime = burstTime;
    waitingTime = 0;
    turnaroundTime = 0;
    completionTime = 0;
}
