#pragma once
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


class ProcessList {
private:
    Node* head;
    int count;
public:
    ProcessList() ;
    void addProcess(Process p);
    Node* getHead();
    int getSize();
};


class DynamicArray{
private:
    Process* data;
    int size;
    int capacity;
    
    void resize();
public:
    DynamicArray(int cap = 4);
    DynamicArray(const DynamicArray& other);
    ~DynamicArray(); 

    void push_back(const Process& value);
    Process &operator[](int index);

    int getSize();
};

