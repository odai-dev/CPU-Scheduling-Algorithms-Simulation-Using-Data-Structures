class Process {
public:
    int id;
    int arrivalTime;
    int burstTime;
    int priority;
    int remainingTime;
    int waitingTime;
    int turnaroundTime;
    int completionTime;

    Process(int id, 
        int arrivalTime,
        int burstTime,
        int priority,
        int remainingTime = 0,
        int waitingTime = 0,
        int turnaroundTime = 0,
        int completionTime = 0
    );
};