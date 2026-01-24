#include "DataStructures.h"
#include <iostream>
using namespace std;


int main() {
    Process x = {1, 2, 1 ,1 ,1 ,1};
    
    Node *Front = NULL, *Rear = NULL; // Queue pointers
    enqueue(Front, Rear, x);
    enqueue(Front, Rear, {2, 5, 20 ,3 ,2 ,1});
    enqueue(Front, Rear,  {3, 5, 20 ,3 ,2 ,1});
    enqueue(Front, Rear,  {4, 5, 20 ,3 ,2 ,1});

    printQueue(Front);
    printQueue(Front);

}