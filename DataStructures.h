#include <iostream>
using namespace std;

struct Process {
    int id;
    int arrivalTime;
    int burstTime;
    int priority;
    int remainingTime;
    int waitingTime;
    int turnaroundTime;
    int completionTime;
};

struct Node
{
    Process data;
    Node* next;
};

// Queue functions
void enqueue(Node* &front, Node* &rear, Process value);
Process dequeue(Node* &front, Node* &rear);
Process getFront(Node* front);
Process getRear(Node* rear);
bool isQueueEmpty(Node* front);
void printQueue(Node* front);
