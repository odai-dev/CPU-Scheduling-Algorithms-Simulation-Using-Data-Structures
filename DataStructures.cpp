#include "DataStructures.h"



Node* createNode(int value) {
    Node* node = new Node;
    node->data = value;
    node->next = NULL;

    return node;
}

void push(Node* &top, int value) {
    Node* node = createNode(value);
    if (top == NULL) {
        top = node;
        return;
    }
    node->next = top;
    top = node;
}

void print(Node* start) {
    Node* temp = start;
    while (temp != NULL)
    {
        cout<<"| "<<temp->data<<" |"<<endl;
        temp = temp->next;
    }
    cout<<endl;
}
void printStack(Node* top) {
    print(top);
}
int pop(Node* &top) {
    if(top == NULL) return 0;
    Node* temp = top;
    int x = top->data;
    top = top->next;
    delete(temp);
    return x;
}

int getTop(Node* top) {
    if(top == NULL) return 0;
    return top->data;
}

bool isStackEmpty(Node* top) {
    return top == NULL;
}

int size(Node* top) {
    if(top == NULL) return 0;
    Node* temp  = top;
    int count = 0;
    while (temp != NULL) {
        count++;
        temp = temp->next;
    }
    return count;
}


// Queue
void enqueue(Node* &front, Node* &rear, int value) {
    Node* node = createNode(value);
    if(rear == front && front == NULL) {
        rear = front = node;
        return;
    }
    rear->next = node;
    rear = node;
}

int dequeue(Node* &front, Node* &rear) {
    int x = 0;
    if(rear == front && front == NULL) {
        return x;
    } else if (front == rear) {
        Node* temp = front;
        x = front->data;
        front = NULL;
        rear = NULL;
        delete(temp);
        return x;
    } else {
        Node* temp = front;
        x = front->data;
        front = front->next;
        delete(temp);
        return x;
    }
}

int getFront(Node* front) {
    if(front == NULL) return 0;
    return front->data;
}
int getRear(Node* rear) {
    if(rear == NULL) return 0;
    return rear->data;
}

void printQueue(Node* front) {
    print(front);
}
bool isQueueEmpty(Node* front) {
    return front == NULL;
}