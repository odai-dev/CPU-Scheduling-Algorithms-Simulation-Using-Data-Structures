#include <iostream>
using namespace std;

struct Node
{
    int data;
    Node* next;
};


typedef Node* nodeptr;


// Stack functions
void push(nodeptr &top, int value);
int pop(nodeptr &top);
int getTop(nodeptr top);
bool isStackEmpty(nodeptr top);
int size(nodeptr top);
void printStack(nodeptr top);

// Queue functions
void enqueue(nodeptr &front, nodeptr &rear, int value);
int dequeue(nodeptr &front, nodeptr &rear);
int getFront(nodeptr front);
int getRear(nodeptr rear);
bool isQueueEmpty(nodeptr front);
void printQueue(nodeptr front);
