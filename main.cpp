#include "DataStructures.h"
#include <iostream>
using namespace std;


int main() {
    Node *Front = NULL, *Rear = NULL; // Queue pointers
    Process processes[5] = {
    // ID, Arrival, Burst, Priority, Remaining, Waiting, Turnaround, Completion
    {1, 0, 5, 2, 5, 0, 0, 0},
    {2, 1, 3, 1, 3, 0, 0, 0},
    {3, 2, 8, 3, 8, 0, 0, 0},
    {4, 3, 2, 4, 2, 0, 0, 0},
    {5, 4, 4, 2, 4, 0, 0, 0}
};
    for(int i = 0; i<5; i++) {
        enqueue(Front, Rear, processes[i]);
    }
    printQueue(Front);

}