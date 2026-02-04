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
    void addProcess(Process p); // Sorted insert
    void push_back(Process p);  // Append to end
    void clear();
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
    void removeLast();
};


class PriorityQueue {
private: 
    DynamicArray heap;
    bool isMinHeap;

    int parent(int i) {return (i-1)/2;};
    int leftChild(int i) {return 2*i+1;};
    int rightChild(int i) {return 2*i+2;};

    void heapifyUp(int index);
    void heapifyDown(int index);

    bool hasHigherPriority(Process p1, Process p2);

    void swap(int p1, int p2);

public:
    PriorityQueue(bool minMode);

    void enqueue(Process p);
    Process dequeue();
    Process peek();
    bool isEmpty();
    int getSize();
};