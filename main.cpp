#include "DataStructures.h"
#include <iostream>
using namespace std;


int main() {
    Process processes[5] = {
        // ID, Arrival, Burst, Priority, Remaining, Waiting, Turnaround, Completion
        {1, 0, 5, 2, 5, 0, 0, 0},
        {2, 1, 3, 1, 3, 0, 0, 0},
        {3, 2, 8, 3, 8, 0, 0, 0},
        {4, 3, 2, 4, 2, 0, 0, 0},
        {5, 4, 4, 2, 4, 0, 0, 0}
    };

    ProcessQueue q;

    for(int i = 0; i < 5; i++) {
        q.enqueue(processes[i]);
    }

    cout << "Initial queue:\n";
    q.print();

    for(int i = 0; i < 5; i++) {
        Process p = q.dequeue();
        cout << "Dequeued Process ID: " << p.id
             << " | Arrival: " << p.arrivalTime
             << " | Burst: " << p.burstTime
             << " | Priority: " << p.priority << endl;
        cout << "Queue after dequeue:\n";
        q.print();
    }

    cout << "Attempting to dequeue from empty queue:\n";
    Process p = q.dequeue();
    cout << "Dequeued Process ID: " << p.id << endl;
}