#include "DataStructures.h"
#include <iostream>
using namespace std;


int main() {
    Node *Front = NULL, *Rear = NULL; // Queue pointers
    enqueue(Front, Rear, 10);
    enqueue(Front, Rear, 20);
    enqueue(Front, Rear, 30);
    enqueue(Front, Rear, 40);

    printQueue(Front);
    cout<<dequeue(Front, Rear)<<endl;
    printQueue(Front);

}