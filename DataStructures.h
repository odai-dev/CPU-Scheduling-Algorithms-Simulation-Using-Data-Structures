#include <iostream>
using namespace std;

struct Node
{
    int data;
    Node* next;
};



// Stack functions
void push(Node* &top, int value);
int pop(Node* &top);
int getTop(Node* top);
bool isStackEmpty(Node* top);
int size(Node* top);
void printStack(Node* top);

// Queue functions
void enqueue(Node* &front, Node* &rear, int value);
int dequeue(Node* &front, Node* &rear);
int getFront(Node* front);
int getRear(Node* rear);
bool isQueueEmpty(Node* front);
void printQueue(Node* front);
