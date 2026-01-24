#include <iostream>
#include "Process.h"
using namespace std;


class Node {
public:
    Process data;
    Node* next;
    Node(Process p) : data(p), next(nullptr) {
        if (data.id < 0) {
            throw invalid_argument("invalid id");
        }
    }
};

class ProcessQueue {
private:
    Node* front;
    Node* rear;
public:
    ProcessQueue();
    ~ProcessQueue();
    void enqueue(Process value);
    Process dequeue();
    Process getFront();
    Process getRear();
    bool isEmpty();
    void print();
};