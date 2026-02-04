#pragma once
#include "DataStructures.h"

class Scheduler {
public:
    static ProcessList timeline; // Stores the execution timeline (Gantt Chart data)
    static ProcessList runFCFS(ProcessList& masterList);
    static ProcessList runSJF(ProcessList& masterList, bool preemptive);
    static ProcessList runPriority(ProcessList& masterList, bool preemptive);
    static ProcessList roundRobin(ProcessList& masterList, int quantom);

private:
    static void diplayStats(ProcessList& completedProcesses);
};