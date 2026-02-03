#pragma once
#include "DataStructures.h"

class Scheduler {
public:
    static void runFCFS(ProcessList& masterList);
    static void runSJF(ProcessList& masterList, bool preemptive);
    static void runPriority(ProcessList& masterList);

private:
    static void diplayStats(ProcessList& completedProcesses);
};