#include "DataStructures.h"



nodeptr createNode(int value) {
    nodeptr node = new Node;
    node->data = value;
    node->next = NULL;

    return node;
}

void push(nodeptr &top, int value) {
    nodeptr node = createNode(value);
    if (top == NULL) {
        top = node;
        return;
    }
    node->next = top;
    top = node;
}

void print(nodeptr start) {
    nodeptr temp = start;
    while (temp != NULL)
    {
        cout<<"| "<<temp->data<<" |"<<endl;
        temp = temp->next;
    }
    cout<<endl;
}
void printStack(nodeptr top) {
    print(top);
}
int pop(nodeptr &top) {
    if(top == NULL) return 0;
    nodeptr temp = top;
    int x = top->data;
    top = top->next;
    delete(temp);
    return x;
}

int getTop(nodeptr top) {
    if(top == NULL) return 0;
    return top->data;
}

bool isStackEmpty(nodeptr top) {
    return top == NULL;
}

int size(nodeptr top) {
    if(top == NULL) return 0;
    nodeptr temp  = top;
    int count = 0;
    while (temp != NULL) {
        count++;
        temp = temp->next;
    }
    return count;
}


// Queue
void enqueue(nodeptr &front, nodeptr &rear, int value) {
    nodeptr node = createNode(value);
    if(rear == front && front == NULL) {
        rear = front = node;
        return;
    }
    rear->next = node;
    rear = node;
}

int dequeue(nodeptr &front, nodeptr &rear) {
    int x = 0;
    if(rear == front && front == NULL) {
        return x;
    } else if (front == rear) {
        nodeptr temp = front;
        x = front->data;
        front = NULL;
        rear = NULL;
        delete(temp);
        return x;
    } else {
        nodeptr temp = front;
        x = front->data;
        front = front->next;
        delete(temp);
        return x;
    }
}

int getFront(nodeptr front) {
    if(front == NULL) return 0;
    return front->data;
}
int getRear(nodeptr rear) {
    if(rear == NULL) return 0;
    return rear->data;
}

void printQueue(nodeptr front) {
    print(front);
}
bool isQueueEmpty(nodeptr front) {
    return front == NULL;
}