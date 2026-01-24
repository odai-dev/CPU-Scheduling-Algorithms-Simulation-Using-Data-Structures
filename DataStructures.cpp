#include "DataStructures.h"


Node* createNode(Process value) {
    Node* newNode = new Node;
    newNode->data = value;
    newNode->next = NULL;

    return newNode;
}

// Queue
void enqueue(Node* &front, Node* &rear, Process value) {
    Node* newNode = createNode(value);
    if(rear == front && front == NULL) {
        rear = front = newNode;
        return;
    }
    rear->next = newNode;
    rear = newNode;
}

Process dequeue(Node* &front, Node* &rear) {
    Process x;
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

Process getFront(Node* front) {
    if(front == NULL) return {-1, 0, 0, 0, 0, 0, 0, 0};
    return front->data;
}
Process getRear(Node* rear) {
    if(rear == NULL) return {-1, 0, 0, 0, 0, 0, 0, 0};
    return rear->data;
}

void printQueue(Node* front) {
    Node* temp = front;
    while (temp != NULL)
    {
        cout<<"| "<<temp->data.id<<" |"<<endl;
        temp = temp->next;
    }
    cout<<endl;
}
bool isQueueEmpty(Node* front) {
    return front == NULL;
}