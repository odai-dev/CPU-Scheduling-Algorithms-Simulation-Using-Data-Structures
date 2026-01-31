class Process {
public:
    int id;
    int arrivalTime;
    int burstTime;
    int priority;
    
    // Managed by the Scheduler
    int remainingTime;
    int waitingTime;
    int turnaroundTime;
    int completionTime;

    Process();
    Process(int id, int arrivalTime, int burstTime, int priority = 0);
};