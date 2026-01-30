#include "Process.h"

Process::Process(int id, int arrivalTime, int burstTime, int priority,
                 int remainingTime, int waitingTime, int turnaroundTime, int completionTime)
    : id(id), arrivalTime(arrivalTime), burstTime(burstTime), priority(priority),
      remainingTime(remainingTime), waitingTime(waitingTime),
      turnaroundTime(turnaroundTime), completionTime(completionTime) {}