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
        return {-1, 0, 0, 0};
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
    if(isEmpty()) return {-1, 0, 0, 0};
    return front->data;
}
Process ProcessQueue::getRear() {
    if(rear == NULL) return {-1, 0, 0, 0};
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

// Dynamic arrays will be needed for creating Binary Heap to implement priority queues 
// The most typical and efficint method

DynamicArray::DynamicArray(int cap) {
    capacity = (cap > 0) ? cap : 1;
    size = 0;
    data = new Process[capacity];
}
// a Copy Constructor to satisfy the Rule of Three
DynamicArray::DynamicArray(const DynamicArray& other) {
    capacity = other.capacity;
    size = other.size;
    data = new Process[capacity];
    for (int i = 0; i < size; i++) {
        data[i] = other.data[i];
    }
}


DynamicArray::~DynamicArray() {
    delete[] data;
}

void DynamicArray::resize() {
    capacity *= 2;
    Process* newData = new Process[capacity];

    for (int i = 0; i<size; i++) {
        newData[i] = data[i];
    }
    delete[] data;
    data = newData;
}

void DynamicArray::push_back(const Process& value) {
    if (size == capacity) resize();
    data[size++] = value;
}

// Overloads the subscript operator to allow DynamicArray objects
// to be accessed like a regular array e.g arr[i] instead of heap.data[i]
Process& DynamicArray::operator[](int index) {
    return data[index];
}

int DynamicArray::getSize() {
    return size;
}
void DynamicArray::removeLast() {
    if(size > 0) size--;
}

// Priority Queue
void PriorityQueue::insert(Process p) {
    heap.push_back(p);
    heapifyUp(heap.getSize()-1);
};

void PriorityQueue::heapifyUp(int idx) {
    if(idx == 0) return;
    int parentIdx = parent(idx);
    Process p1 = heap[idx];
    Process p2 = heap[parentIdx];
    if(hasHigherPriority( p1,  p2)) {
        swap(idx, parentIdx);
        heapifyUp(parentIdx);
    }
}

void PriorityQueue::swap(int p1, int p2) {
    Process temp = heap[p2];
    heap[p2] = heap[p1];
    heap[p1] = temp;
}