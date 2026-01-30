#include "DataStructures.h"

ProcessQueue::ProcessQueue() : front(nullptr), rear(nullptr) {}

ProcessQueue::~ProcessQueue() {
    while (!isEmpty())
    {
        dequeue();
    }
    
}

void ProcessQueue::enqueue( Process value) {
    Node* newNode = new Node(value);
    if(isEmpty()) {
        rear = front = newNode;
        return;
    } else {
        rear->next = newNode;
        rear = newNode;        
    }
}

Process ProcessQueue::dequeue() {
    if(isEmpty()) {
        return {-1, 0, 0, 0, 0, 0 , 0, 0};
    } 
    
    Node* temp = front;
    Process p  = front->data;

    if(front == rear) {
        front = rear = nullptr;
    } else {
        front = front->next;
    }

    delete(temp);
    return p;
}

Process ProcessQueue::getFront() {
    if(isEmpty()) return {-1, 0, 0, 0, 0, 0, 0, 0};
    return front->data;
}
Process ProcessQueue::getRear() {
    if(rear == NULL) return {-1, 0, 0, 0, 0, 0, 0, 0};
    return rear->data;
}

void ProcessQueue::print() {
    Node* temp = front;
    while (temp != NULL)
    {
        cout<<"| "<<temp->data.id<<" |"<<endl;
        temp = temp->next;
    }
    cout<<endl;
}
bool ProcessQueue::isEmpty() {
    return front == NULL;
}

ProcessList::ProcessList() : head(nullptr), count(0) {}

void ProcessList::addProcess(Process p) {
    Node* newNode = new Node(p);
    if(head == NULL) {
        head = newNode;
    } else {
        Node* temp = head;
        while (temp->next != nullptr){
            temp = temp->next;
        }
        temp->next = newNode;
    }
    count++;
}

Node* ProcessList::getHead() {
    return head;
}

int ProcessList::getSize() {
    return count;
}