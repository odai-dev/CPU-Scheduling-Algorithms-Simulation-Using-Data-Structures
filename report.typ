// Document Configuration
#set document(
  title: "CPU Scheduling Algorithms Simulation Using Data Structures",
  author: "Student Name",
)
#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2.5cm),
  numbering: "1",
  header: align(right)[
    _CPU Scheduling Algorithms Simulation_
  ],
)
#set text(size: 11pt)
#set heading(numbering: "1.1")
#set par(justify: true)

// Title Page
#align(center)[
  #v(2cm)
  #text(size: 14pt, weight: "bold")[Ar-Rasheed Smart University]
  
  #text(size: 12pt)[College of Engineering and Information Technology]
  
  #v(1cm)
  
  #text(size: 24pt, weight: "bold")[
    CPU Scheduling Algorithms Simulation Using Data Structures
  ]
  
  #v(1cm)
  
  #text(size: 14pt)[DSA Project]
  
  #v(2cm)
  
  #text(size: 12pt)[
    *Theory Instructor:* Dr. Belal Murshed
    
    *Lab Instructor:* T. Mohammed Al-Sayani
    
    *Student Name:* Odai Masnoor Gubran
    
    *Student ID:* 202410100532
  ]
  
  #v(2cm)
  
  #text(size: 12pt)[February 2026]
]

#pagebreak()

// Table of Contents
#outline(
  title: "Table of Contents",
  indent: auto,
)

#pagebreak()

= Introduction

== Aims of the Project

The primary aims of this project are:

1. To design and implement a comprehensive *CPU scheduling simulator* that models real operating-system scheduling behaviour using C++.

2. To implement and compare multiple classical CPU scheduling algorithms, including:
   - First Come First Serve (FCFS)
   - Shortest Job First (SJF) - Preemptive and Non-Preemptive
   - Priority Scheduling - Preemptive and Non-Preemptive
   - Round Robin (RR)

3. To analyse scheduling performance quantitatively using key metrics such as:
   - Average Waiting Time
   - Average Turnaround Time
   - Completion Time for each process

4. To provide an educational tool that helps students understand scheduling trade-offs, starvation, fairness, preemption, and efficiency.

5. To demonstrate practical use of data structures (Queue, Priority Queue, Linked List, Dynamic Array) in operating-system simulations.

6. To enable algorithm comparison under identical workloads, ensuring fair and consistent evaluation.

== Characteristics of the Project

=== Functional Characteristics
- Supports multiple scheduling algorithms within a single executable
- Handles process input with customizable arrival times, burst times, and priorities
- Displays step-by-step execution order (Gantt chart data)
- Provides performance metrics for algorithm comparison

=== Technical Characteristics
- Written in standard C++
- Uses custom data structures (no built-in scheduling libraries)
- Implements both preemptive and non-preemptive logic
- Modular class-based architecture
- Separate header and implementation files

=== Educational Characteristics
- Clear separation of algorithms
- Explicit metric calculation
- Emphasis on algorithm behaviour and trade-offs
- Code comments explaining key concepts

=== Performance Characteristics
- Time complexity ranges from O(n) to O(n log n) depending on algorithm
- Designed for correctness and clarity
- Priority Queue uses efficient binary heap implementation

#pagebreak()

= Data Structures

This section details the custom data structures implemented for the scheduling algorithms. *No built-in scheduling libraries were used* — all structures are implemented from scratch.

== Process Struct

=== Purpose
The `Process` struct models a process with all attributes required for CPU scheduling algorithms, including both preemptive and non-preemptive scheduling. It is used in simulations of FCFS, SJF, Priority Scheduling, and Round Robin.

=== Attributes

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: (left, left, left),
  [*Attribute*], [*Type*], [*Description*],
  [`id`], [`int`], [Unique identifier for the process],
  [`arrivalTime`], [`int`], [Time at which the process arrives in the ready queue],
  [`burstTime`], [`int`], [Total CPU time required by the process],
  [`priority`], [`int`], [Priority level (lower number = higher priority)],
  [`remainingTime`], [`int`], [Tracks remaining CPU time (for preemptive scheduling)],
  [`waitingTime`], [`int`], [Total time spent waiting in ready queue],
  [`turnaroundTime`], [`int`], [Total time from arrival to completion],
  [`completionTime`], [`int`], [Time at which the process finishes execution],
)

=== Constructor
The constructor initializes a Process object with:
- `id`, `arrivalTime`, `burstTime`, and `priority` as provided
- `remainingTime` is set to `burstTime` (initially, full CPU time is remaining)
- `completionTime`, `waitingTime`, and `turnaroundTime` are initialized to 0

=== Implementation
```cpp
class Process {
public:
    int id;
    int arrivalTime;
    int burstTime;
    int priority;
    
    // Managed by the Scheduler
    int remainingTime;
    int waitingTime;
    int turnaroundTime;
    int completionTime;

    Process();
    Process(int id, int arrivalTime, int burstTime, int priority = 0);
};
```

=== Implementation Notes

*Preemptive vs. Non-Preemptive Scheduling:*
- `remainingTime` is crucial for preemptive algorithms (Round Robin, Preemptive SJF, Preemptive Priority)
- For non-preemptive algorithms (FCFS), `remainingTime` is not actively used

*Performance Metrics:*
- `waitingTime` and `turnaroundTime` are computed after scheduling to evaluate algorithm efficiency
- Waiting Time = Turnaround Time - Burst Time
- Turnaround Time = Completion Time - Arrival Time

=== Workflow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    Process Lifecycle                         │
├─────────────────────────────────────────────────────────────┤
│  [Created] → [Ready Queue] → [Running] → [Completed]        │
│      │            │              │            │              │
│   arrivalTime   waitingTime   executing   completionTime    │
│                              burstTime                       │
└─────────────────────────────────────────────────────────────┘
```

#pagebreak()

== Node Structure

=== Purpose
A generic node for linked structures that holds process data and a pointer to the next node.

=== Implementation
```cpp
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
```

=== Key Points
- Contains a `Process` object and a `next` pointer
- Used by `ProcessQueue` and `ProcessList` classes
- Includes validation to prevent invalid process IDs

#pagebreak()

== ProcessQueue Class

=== Purpose
Implements a *First-In-First-Out (FIFO)* queue structure, essential for:
- *FCFS Algorithm*: Processes are served in arrival order
- *Round Robin Algorithm*: Processes cycle through the ready queue

=== Components

*Private Members:*
- `Node* front`: Pointer to the first node in the queue
- `Node* rear`: Pointer to the last node in the queue

*Public Methods:*

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  [*Method*], [*Time Complexity*], [*Description*],
  [`enqueue(Process)`], [O(1)], [Adds process to rear of queue],
  [`dequeue()`], [O(1)], [Removes and returns front process],
  [`getFront()`], [O(1)], [Returns front process without removing],
  [`getRear()`], [O(1)], [Returns rear process without removing],
  [`isEmpty()`], [O(1)], [Returns true if queue is empty],
  [`print()`], [O(n)], [Displays all processes in queue],
)

=== Implementation
```cpp
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
```

=== Implementation Details

*enqueue():*
```cpp
void ProcessQueue::enqueue(Process value) {
    Node* newNode = new Node(value);
    if(isEmpty()) {
        rear = front = newNode;
        return;
    } else {
        rear->next = newNode;
        rear = newNode;        
    }
}
```

*dequeue():*
```cpp
Process ProcessQueue::dequeue() {
    if(isEmpty()) {
        return {-1, 0, 0, 0};  // Invalid process
    } 
    Node* temp = front;
    Process p = front->data;
    if(front == rear) {
        front = rear = nullptr;
    } else {
        front = front->next;
    }
    delete(temp);
    return p;
}
```

=== Workflow Diagram

```
Queue Operations:
                    
  enqueue(P3)                    dequeue()
      │                              │
      ▼                              ▼
┌────────────────────────────────────────┐
│  front                          rear   │
│    │                             │     │
│    ▼                             ▼     │
│  ┌────┐    ┌────┐    ┌────┐    ┌────┐  │
│  │ P1 │───▶│ P2 │───▶│ P3 │───▶│ P4 │  │
│  └────┘    └────┘    └────┘    └────┘  │
│    ▲                                   │
│    │                                   │
│  Returns P1                            │
└────────────────────────────────────────┘
```

#pagebreak()

== ProcessList Class

=== Purpose
Implements a singly-linked list to manage processes with two insertion modes:
1. *Sorted Insert* (`addProcess`): Maintains arrival time order
2. *Append* (`push_back`): Adds to the end (for timeline/Gantt chart data)

=== Components

*Private Members:*
- `Node* head`: Pointer to the first node in the list
- `int count`: Number of processes in the list

*Public Methods:*

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  [*Method*], [*Time Complexity*], [*Description*],
  [`addProcess(Process)`], [O(n)], [Inserts sorted by arrival time],
  [`push_back(Process)`], [O(n)], [Appends to end of list],
  [`clear()`], [O(n)], [Removes all processes],
  [`getHead()`], [O(1)], [Returns pointer to first node],
  [`getSize()`], [O(1)], [Returns number of processes],
)

=== Implementation
```cpp
class ProcessList {
private:
    Node* head;
    int count;
public:
    ProcessList();
    void addProcess(Process p);  // Sorted by arrival time
    void push_back(Process p);   // Append to end
    void clear();
    Node* getHead();
    int getSize();
};
```

=== Use Cases in Project
- *Master List*: Stores all input processes sorted by arrival time
- *Timeline*: Records execution slices for Gantt chart visualization
- *Completed Processes*: Stores processes after they finish execution

=== Important Notes

*Memory Management:*
- The `clear()` method properly deallocates all nodes
- Destructor should be implemented to prevent memory leaks

*Sorting Behaviour:*
- `addProcess()` maintains sorted order by arrival time
- For processes with same arrival time, insertion order is preserved

#pagebreak()

== DynamicArray Class

=== Purpose
A resizable array that provides the foundation for the Priority Queue implementation. Automatically grows when capacity is reached.

=== Components

*Private Members:*
- `Process* data`: Pointer to the underlying array
- `int size`: Current number of elements
- `int capacity`: Maximum current capacity
- `resize()`: Doubles capacity when full

*Public Methods:*

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  [*Method*], [*Time Complexity*], [*Description*],
  [`push_back(Process)`], [O(1) amortized], [Adds element to end],
  [`operator[](int)`], [O(1)], [Array-style access],
  [`getSize()`], [O(1)], [Returns current size],
  [`removeLast()`], [O(1)], [Removes last element],
)

=== Implementation
```cpp
class DynamicArray {
private:
    Process* data;
    int size;
    int capacity;
    void resize();
public:
    DynamicArray(int cap = 4);
    DynamicArray(const DynamicArray& other);  // Copy constructor
    ~DynamicArray();
    void push_back(const Process& value);
    Process& operator[](int index);
    int getSize();
    void removeLast();
};
```

=== Key Features

*Automatic Resizing:*
```cpp
void DynamicArray::resize() {
    capacity *= 2;
    Process* newData = new Process[capacity];
    for (int i = 0; i < size; i++) {
        newData[i] = data[i];
    }
    delete[] data;
    data = newData;
}
```

*Copy Constructor (Rule of Three):*
```cpp
DynamicArray::DynamicArray(const DynamicArray& other) {
    capacity = other.capacity;
    size = other.size;
    data = new Process[capacity];
    for (int i = 0; i < size; i++) {
        data[i] = other.data[i];
    }
}
```

#pagebreak()

== PriorityQueue Class (Binary Heap)

=== Purpose
The Priority Queue is implemented as a *Binary Heap* stored in a Dynamic Array. It supports both min-heap and max-heap modes for different scheduling algorithms:
- *Min-Heap Mode*: For SJF — prioritizes smaller remaining time
- *Max-Heap Mode (by priority value)*: For Priority Scheduling — prioritizes lower priority numbers

=== Components

*Private Members:*
- `DynamicArray heap`: Underlying storage
- `bool isMinHeap`: Mode selector
- Helper functions: `parent()`, `leftChild()`, `rightChild()`
- `heapifyUp()`, `heapifyDown()`: Maintain heap property
- `hasHigherPriority()`: Comparison based on mode
- `swap()`: Exchange elements

*Public Methods:*

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  [*Method*], [*Time Complexity*], [*Description*],
  [`enqueue(Process)`], [O(log n)], [Adds and heapifies up],
  [`dequeue()`], [O(log n)], [Removes root and heapifies down],
  [`peek()`], [O(1)], [Returns root without removing],
  [`isEmpty()`], [O(1)], [Checks if empty],
  [`getSize()`], [O(1)], [Returns number of elements],
)

=== Implementation
```cpp
class PriorityQueue {
private: 
    DynamicArray heap;
    bool isMinHeap;

    int parent(int i) { return (i-1)/2; }
    int leftChild(int i) { return 2*i+1; }
    int rightChild(int i) { return 2*i+2; }

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
```

=== Priority Comparison Logic
```cpp
bool PriorityQueue::hasHigherPriority(Process p1, Process p2) {
    if (isMinHeap) {
        // SJF: Compare by remaining time
        if (p1.remainingTime == p2.remainingTime) {
            return p1.arrivalTime < p2.arrivalTime;  // Tiebreaker
        }
        return p1.remainingTime < p2.remainingTime;
    } else {
        // Priority Scheduling: Compare by priority value
        if (p1.priority == p2.priority) {
            return p1.arrivalTime < p2.arrivalTime;  // Tiebreaker
        }
        return p1.priority < p2.priority;
    }
}
```

=== Workflow Diagram

```
Binary Heap Structure (Min-Heap by remaining time):

              ┌───────┐
              │ P1(2) │  ← Root (smallest remaining time)
              └───┬───┘
          ┌───────┴───────┐
      ┌───┴───┐       ┌───┴───┐
      │ P2(3) │       │ P3(5) │
      └───┬───┘       └───┬───┘
    ┌─────┴─────┐   ┌─────┴─────┐
┌───┴───┐   ┌───┴───┐
│ P4(7) │   │ P5(4) │
└───────┘   └───────┘

Array representation: [P1, P2, P3, P4, P5]
Indices:               0    1    2    3    4

Parent of i: (i-1)/2
Left child of i: 2*i+1
Right child of i: 2*i+2
```

#pagebreak()

= Scheduling Algorithms

== First Come First Serve (FCFS)

=== Purpose
FCFS is the simplest scheduling algorithm. Processes are executed in the order they arrive in the ready queue. It is *non-preemptive* — once a process starts, it runs to completion.

=== Key Components
- *ProcessQueue*: Holds ready processes in FIFO order
- *ProcessList*: Stores completed processes and execution timeline

=== Implementation Principles
1. Processes are sorted by arrival time in a linked list
2. As processes arrive, they are added to a FIFO queue
3. The CPU executes each process completely before moving to the next
4. Handles idle CPU time when no processes are available

=== Implementation
```cpp
ProcessList Scheduler::runFCFS(ProcessList &masterList) {
   ProcessQueue readyQueue;
   int currentTime = 0;
   int completed = 0;
   Node* it = masterList.getHead();
   int total = masterList.getSize();
   ProcessList completedProcesses;
   timeline.clear();

   while(completed < total) {
        // Add arrived processes to ready queue
        while(it != nullptr && it->data.arrivalTime <= currentTime) {
            readyQueue.enqueue(it->data);
            it = it->next;
        }

        if(!readyQueue.isEmpty()) {
            Process p = readyQueue.dequeue();
            
            // Log for Gantt Chart
            Process slice = p;
            slice.arrivalTime = currentTime;  // Start Time
            slice.burstTime = p.burstTime;    // Duration
            timeline.push_back(slice);

            p.waitingTime = currentTime - p.arrivalTime;
            currentTime += p.burstTime;
            p.completionTime = currentTime;
            p.turnaroundTime = p.waitingTime + p.burstTime;

            completedProcesses.addProcess(p);
            completed++;
        } else {
            // Handle idle CPU
            if (it != nullptr) {
                currentTime = it->data.arrivalTime;
            }
        }
   }
   return completedProcesses;
}
```

=== Important Notes

#table(
  columns: (auto, auto),
  inset: 8pt,
  [*Property*], [*Value*],
  [Type], [Non-Preemptive],
  [Starvation], [No — all processes eventually execute],
  [Convoy Effect], [Yes — short processes wait for long ones],
  [Overhead], [Minimal — no context switching during execution],
  [Fairness], [Fair in order of arrival],
)

=== Workflow Diagram

```
FCFS Algorithm Flow:

┌─────────────┐
│   Start     │
└──────┬──────┘
       ▼
┌──────────────────┐
│ Initialize Queue │
│ currentTime = 0  │
└────────┬─────────┘
         ▼
┌────────────────────────┐
│ While not all complete │◄─────────────────┐
└────────┬───────────────┘                  │
         ▼                                  │
┌────────────────────────┐                  │
│ Add arrived processes  │                  │
│ to ready queue         │                  │
└────────┬───────────────┘                  │
         ▼                                  │
    ┌────────────┐                          │
    │Queue empty?│                          │
    └─────┬──────┘                          │
      No  │  Yes                            │
          ▼    ▼                            │
┌─────────────┐ ┌──────────────┐            │
│ Dequeue &   │ │ Skip to next │            │
│ Execute     │ │ arrival time │            │
└──────┬──────┘ └──────┬───────┘            │
       │               │                    │
       ▼               ▼                    │
┌──────────────────────────────┐            │
│ Calculate WT, TAT, CT        │            │
│ Add to completed list        │────────────┘
└──────────────────────────────┘
```

#pagebreak()

== Shortest Job First (SJF)

=== Purpose
SJF selects the process with the *smallest burst time* (or remaining time in preemptive mode). This algorithm minimizes average waiting time but requires knowing burst times in advance.

=== Key Features
- *Non-Preemptive SJF*: Once started, process runs to completion
- *Preemptive SJF (SRTF)*: Process can be interrupted if a shorter job arrives
- Uses Priority Queue (Min-Heap) ordered by remaining time

=== Implementation Principles
1. Use a min-heap priority queue ordered by remaining time
2. When a process arrives, add it to the priority queue
3. Always execute the process with smallest remaining time
4. For preemptive: re-evaluate after each time unit

=== Implementation
```cpp
ProcessList Scheduler::runSJF(ProcessList &masterList, bool preemptive) {
    PriorityQueue pq(true);  // Min-heap for shortest job
    int currentTime = 0;
    int completed = 0;
    Node* it = masterList.getHead();
    int total = masterList.getSize();
    ProcessList completedProcesses;
    timeline.clear();

    while (completed < total) {
        // Add arrived processes to priority queue
        while(it != nullptr && it->data.arrivalTime <= currentTime) {
            pq.enqueue(it->data);
            it = it->next;
        }

        if(!pq.isEmpty()) {
            if(preemptive) {
                Process p = pq.dequeue();
                
                // Log 1-unit slice for Gantt Chart
                Process slice = p;
                slice.arrivalTime = currentTime;
                slice.burstTime = 1;
                timeline.push_back(slice);

                p.remainingTime--;
                currentTime++;
                
                if(p.remainingTime > 0) pq.enqueue(p);
                if(p.remainingTime == 0) {
                    p.completionTime = currentTime;
                    p.waitingTime = p.completionTime - p.arrivalTime - p.burstTime;
                    p.turnaroundTime = p.waitingTime + p.burstTime;
                    completed++;
                    completedProcesses.addProcess(p);
                }
            } else {
                // Non-preemptive: run full burst
                Process p = pq.dequeue();
                
                // Log full slice
                Process slice = p;
                slice.arrivalTime = currentTime;
                slice.burstTime = p.burstTime;
                timeline.push_back(slice);

                p.waitingTime = currentTime - p.arrivalTime;
                currentTime += p.burstTime;
                p.completionTime = currentTime;
                p.turnaroundTime = p.waitingTime + p.burstTime;
                completedProcesses.addProcess(p);
                completed++;
            }
        } else {
            if(it != nullptr) currentTime = it->data.arrivalTime;
        }
    }
    return completedProcesses;
}
```

=== Important Notes

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  [*Property*], [*Non-Preemptive*], [*Preemptive (SRTF)*],
  [Optimal AWT], [Yes (among non-preemptive)], [Yes (overall optimal)],
  [Starvation], [Possible for long jobs], [Possible for long jobs],
  [Context Switches], [Low], [High (every time unit)],
  [Implementation], [Simpler], [More complex],
)

=== Workflow Diagram

```
SJF Algorithm Flow (Preemptive):

┌─────────────┐
│   Start     │
└──────┬──────┘
       ▼
┌───────────────────────┐
│ Initialize PQ (MinHeap)│
│ currentTime = 0        │
└────────┬──────────────┘
         ▼
┌────────────────────────┐
│ While not all complete │◄──────────────────┐
└────────┬───────────────┘                   │
         ▼                                   │
┌────────────────────────┐                   │
│ Add arrived processes  │                   │
│ to priority queue      │                   │
└────────┬───────────────┘                   │
         ▼                                   │
┌────────────────────────┐                   │
│ Dequeue shortest job   │                   │
└────────┬───────────────┘                   │
         ▼                                   │
┌────────────────────────┐                   │
│ Execute 1 time unit    │                   │
│ remainingTime--        │                   │
└────────┬───────────────┘                   │
         ▼                                   │
    ┌────────────────┐                       │
    │remainingTime=0?│                       │
    └───────┬────────┘                       │
       No   │   Yes                          │
            ▼     ▼                          │
┌───────────────┐ ┌────────────────┐         │
│ Re-enqueue    │ │ Mark complete  │         │
│ process       │ │ Calculate WT   │─────────┘
└───────────────┘ └────────────────┘
```

#pagebreak()

== Priority Scheduling

=== Purpose
Priority Scheduling assigns each process a priority value. The CPU is allocated to the process with the *highest priority* (lowest priority number in this implementation).

=== Key Features
- Lower priority number = Higher priority
- Supports both preemptive and non-preemptive modes
- Uses Priority Queue ordered by priority value
- Ties broken by arrival time

=== Implementation Principles
1. Use a priority queue ordered by priority value
2. Processes with lower priority numbers execute first
3. For preemptive: higher priority process interrupts lower priority
4. For non-preemptive: running process completes before switching

=== Implementation
```cpp
ProcessList Scheduler::runPriority(ProcessList &masterList, bool preemptive) {
    PriorityQueue pq(false);  // Priority-based ordering
    int currentTime = 0;
    int completed = 0;
    Node* it = masterList.getHead();
    int total = masterList.getSize();
    ProcessList completedProcesses;
    timeline.clear();

    while (completed < total) {
        while(it != nullptr && it->data.arrivalTime <= currentTime) {
            pq.enqueue(it->data);
            it = it->next;
        }

        if(!pq.isEmpty()) {
            if (preemptive) {
                Process p = pq.dequeue();
                
                // Log 1-unit slice
                Process slice = p;
                slice.arrivalTime = currentTime;
                slice.burstTime = 1;
                timeline.push_back(slice);

                p.remainingTime--;
                currentTime++;
                if(p.remainingTime > 0) pq.enqueue(p);
                if(p.remainingTime == 0) {
                    p.completionTime = currentTime;
                    p.waitingTime = p.completionTime - p.arrivalTime - p.burstTime;
                    p.turnaroundTime = p.waitingTime + p.burstTime;
                    completed++;
                    completedProcesses.addProcess(p);
                }
            } else {
                Process p = pq.dequeue();
                
                // Log full slice
                Process slice = p;
                slice.arrivalTime = currentTime;
                slice.burstTime = p.burstTime;
                timeline.push_back(slice);

                p.waitingTime = currentTime - p.arrivalTime;
                currentTime += p.burstTime;
                p.completionTime = currentTime;
                p.turnaroundTime = p.waitingTime + p.burstTime;
                completedProcesses.addProcess(p);
                completed++;
            }
        } else {
            if(it != nullptr) currentTime = it->data.arrivalTime;
        }
    }
    return completedProcesses;
}
```

=== Important Notes

#table(
  columns: (auto, auto),
  inset: 8pt,
  [*Property*], [*Value*],
  [Starvation], [Yes — low priority processes may never execute],
  [Solution], [Aging — gradually increase priority over time],
  [Use Case], [Real-time systems, OS kernel tasks],
  [Priority Convention], [Lower number = Higher priority],
)

=== Potential Improvements
- *Aging*: Incrementally increase priority of waiting processes
- *Dynamic Priority*: Adjust priority based on CPU usage
- *Multi-level Queues*: Separate queues for different priority ranges

#pagebreak()

== Round Robin (RR)

=== Purpose
Round Robin allocates the CPU to each process for a fixed *time quantum*. If a process doesn't complete within its quantum, it's moved to the back of the queue. This ensures fair CPU distribution.

=== Key Features
- Preemptive algorithm with fixed time slices
- Uses FIFO queue for ready processes
- Guarantees no starvation
- Good response time for interactive systems

=== Implementation Principles
1. Use a FIFO queue for ready processes
2. Execute each process for at most the time quantum
3. If process not complete, re-enqueue at back of queue
4. Check for new arrivals during each time slice

=== Implementation
```cpp
ProcessList Scheduler::roundRobin(ProcessList &masterList, int quantum) {
    ProcessQueue readyQueue;
    int currentTime = 0;
    int completed = 0;
    Node* it = masterList.getHead();
    int total = masterList.getSize();
    ProcessList completedProcesses;
    timeline.clear();

    while(completed < total) {
        // Load arrived processes
        while(it != nullptr && it->data.arrivalTime <= currentTime) {
            readyQueue.enqueue(it->data);
            it = it->next;
        }

        if(!readyQueue.isEmpty()) {
            Process p = readyQueue.dequeue();
            int timeToRun = (p.remainingTime < quantum) ? p.remainingTime : quantum;
            
            // Log slice for Gantt Chart
            Process slice = p;
            slice.arrivalTime = currentTime;  // Start Time
            slice.burstTime = timeToRun;      // Duration
            timeline.push_back(slice);

            p.remainingTime -= timeToRun;
            currentTime += timeToRun;

            // Check for new arrivals DURING the time slice
            while(it != nullptr && it->data.arrivalTime <= currentTime) {
                readyQueue.enqueue(it->data);
                it = it->next;
            }

            if(p.remainingTime > 0) {
                readyQueue.enqueue(p);  // Back to queue
            } else {
                p.completionTime = currentTime;
                p.waitingTime = p.completionTime - p.arrivalTime - p.burstTime;
                p.turnaroundTime = p.waitingTime + p.burstTime;
                completed++;
                completedProcesses.addProcess(p);
            }
        } else {
            if(it != nullptr) currentTime = it->data.arrivalTime;
        }
    }
    return completedProcesses;
}
```

=== Time Quantum Selection
- *Too Small*: High context switch overhead, poor throughput
- *Too Large*: Degrades to FCFS behaviour
- *Optimal*: Typically 10-100 ms in real systems

=== Important Notes

#table(
  columns: (auto, auto),
  inset: 8pt,
  [*Property*], [*Value*],
  [Type], [Preemptive],
  [Starvation], [No — guaranteed CPU time for all],
  [Fairness], [High — equal time slices],
  [Response Time], [Good for interactive systems],
  [Context Switches], [Higher than FCFS],
)

=== Workflow Diagram

```
Round Robin Algorithm Flow:

┌─────────────┐
│   Start     │
└──────┬──────┘
       ▼
┌───────────────────────┐
│ Initialize Queue      │
│ Set Time Quantum = Q  │
└────────┬──────────────┘
         ▼
┌────────────────────────┐
│ While not all complete │◄──────────────────────┐
└────────┬───────────────┘                       │
         ▼                                       │
┌────────────────────────┐                       │
│ Add arrived processes  │                       │
└────────┬───────────────┘                       │
         ▼                                       │
┌────────────────────────┐                       │
│ Dequeue process P      │                       │
└────────┬───────────────┘                       │
         ▼                                       │
┌────────────────────────────┐                   │
│ Execute min(Q, remaining)  │                   │
│ Update remainingTime       │                   │
└────────┬───────────────────┘                   │
         ▼                                       │
┌────────────────────────────┐                   │
│ Add new arrivals to queue  │                   │
└────────┬───────────────────┘                   │
         ▼                                       │
    ┌────────────────┐                           │
    │remainingTime>0?│                           │
    └───────┬────────┘                           │
       Yes  │   No                               │
            ▼     ▼                              │
┌───────────────┐ ┌────────────────┐             │
│ Re-enqueue P  │ │ Mark complete  │─────────────┘
│ at back       │ │ Calculate WT   │
└───────────────┘ └────────────────┘
```

#pagebreak()

= Helper Functions

== displayStats Function

=== Purpose
Displays the performance metrics for all completed processes after a scheduling algorithm runs.

=== Implementation
```cpp
void Scheduler::diplayStats(ProcessList &completedProcesses) {
    Node* current = completedProcesses.getHead();
    int size = completedProcesses.getSize();
    int totalWaitingTime = 0;
    int totalTurnaroundTime = 0;

    cout << "\n===========================================" << endl;
    cout << "ID\tArrival\tBurst\t| Finish\tWaiting\t\tTurnaround" << endl;
    cout << "-------------------------------------------" << endl;

    while (current != nullptr) {
        cout << "P" << current->data.id << "\t" 
             << current->data.arrivalTime << "\t" 
             << current->data.burstTime << "\t| " 
             << current->data.completionTime << "\t\t"
             << current->data.waitingTime << "\t\t" 
             << current->data.turnaroundTime << endl;

        totalWaitingTime += current->data.waitingTime;
        totalTurnaroundTime += current->data.turnaroundTime;
        current = current->next;
    }
    
    cout << "-------------------------------------------" << endl;
    double AWT = (double)totalWaitingTime / size;
    double ATT = (double)totalTurnaroundTime / size;
    
    cout << "Average Waiting Time:    " << AWT << endl;
    cout << "Average Turnaround Time: " << ATT << endl;
    cout << "===========================================" << endl;
}
```

=== Key Metrics Calculated

*Waiting Time (WT):*
- Time a process spends waiting in ready queue
- Formula: WT = Completion Time - Arrival Time - Burst Time

*Turnaround Time (TAT):*
- Total time from submission to completion
- Formula: TAT = Completion Time - Arrival Time
- Also: TAT = WT + Burst Time

#pagebreak()

= Execution Results

== Sample Input Data

#table(
  columns: (auto, auto, auto, auto),
  inset: 10pt,
  align: center,
  [*Process ID*], [*Arrival Time*], [*Burst Time*], [*Priority*],
  [P1], [0], [5], [3],
  [P2], [1], [3], [2],
  [P3], [2], [4], [1],
  [P4], [3], [2], [5],
  [P5], [50], [4], [4],
)

== FCFS Results

*Execution Order:* P1 → P2 → P3 → P4 → P5

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  inset: 8pt,
  align: center,
  [*Process*], [*Arrival*], [*Burst*], [*Completion*], [*Waiting*], [*Turnaround*],
  [P1], [0], [5], [5], [0], [5],
  [P2], [1], [3], [8], [4], [7],
  [P3], [2], [4], [12], [6], [10],
  [P4], [3], [2], [14], [9], [11],
  [P5], [50], [4], [54], [0], [4],
)

*Average Waiting Time:* 3.8

*Average Turnaround Time:* 7.4

== Non-Preemptive SJF Results

*Execution Order:* P1 → P4 → P2 → P3 → P5

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  inset: 8pt,
  align: center,
  [*Process*], [*Arrival*], [*Burst*], [*Completion*], [*Waiting*], [*Turnaround*],
  [P1], [0], [5], [5], [0], [5],
  [P4], [3], [2], [7], [2], [4],
  [P2], [1], [3], [10], [6], [9],
  [P3], [2], [4], [14], [8], [12],
  [P5], [50], [4], [54], [0], [4],
)

*Average Waiting Time:* 3.2

*Average Turnaround Time:* 6.8

== Round Robin Results (Quantum = 2)

*Execution Order (Gantt Chart):* P1 → P2 → P3 → P4 → P1 → P2 → P3 → P1 → P3 → P5 → P5

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  inset: 8pt,
  align: center,
  [*Process*], [*Arrival*], [*Burst*], [*Completion*], [*Waiting*], [*Turnaround*],
  [P1], [0], [5], [13], [8], [13],
  [P2], [1], [3], [10], [6], [9],
  [P3], [2], [4], [14], [8], [12],
  [P4], [3], [2], [8], [3], [5],
  [P5], [50], [4], [54], [0], [4],
)

*Average Waiting Time:* 5.0

*Average Turnaround Time:* 8.6

#pagebreak()

= Performance Comparison

== Summary Table

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: center,
  [*Algorithm*], [*Avg Waiting Time*], [*Avg Turnaround Time*],
  [FCFS], [3.8], [7.4],
  [SJF (Non-Preemptive)], [3.2], [6.8],
  [SJF (Preemptive/SRTF)], [2.6], [6.2],
  [Priority (Non-Preemptive)], [4.0], [7.6],
  [Round Robin (Q=2)], [5.0], [8.6],
)

== Analysis

=== Best Average Waiting Time
*SRTF (Preemptive SJF)* achieves the lowest average waiting time because it always runs the process closest to completion, minimizing wait for all processes.

=== Best for Interactive Systems
*Round Robin* provides the best response time for interactive applications, ensuring all processes get regular CPU access regardless of their burst time.

=== Simplest Implementation
*FCFS* is the simplest to implement with minimal overhead, but suffers from the convoy effect where short processes wait behind long ones.

=== When to Use Each Algorithm

#table(
  columns: (auto, auto),
  inset: 8pt,
  [*Algorithm*], [*Best Use Case*],
  [FCFS], [Batch processing, simple systems],
  [SJF], [When burst times are known, minimizing AWT],
  [Priority], [Real-time systems, critical tasks],
  [Round Robin], [Time-sharing systems, interactive applications],
)

#pagebreak()

= Bonus Features

== Graphical User Interface (GUI)

A graphical user interface was implemented using *Dear ImGui* (with GLFW and OpenGL backends) to provide interactive process input, algorithm selection, and Gantt chart visualization. The GUI was developed with assistance from *Gemini CLI*.

#pagebreak()

= Conclusion

This project successfully demonstrates the implementation and comparison of four major CPU scheduling algorithms using custom data structures. Key achievements include:

1. *Complete Implementation* of FCFS, SJF (both variants), Priority Scheduling (both variants), and Round Robin algorithms.

2. *Custom Data Structures* including Queue, Priority Queue (Binary Heap), Linked List, and Dynamic Array — all built from scratch without using standard library scheduling containers.

3. *Performance Analysis* showing that SRTF provides optimal average waiting time while Round Robin offers better fairness for interactive systems.

4. *Modular Design* with separate header and implementation files for maintainability.

5. *Bonus GUI* using Dear ImGui for interactive visualization.

== Key Takeaways

- Different algorithms excel in different scenarios
- Trade-offs exist between waiting time, turnaround time, and fairness
- Data structure choice significantly impacts algorithm efficiency
- Priority Queue (heap) enables O(log n) operations for SJF and Priority scheduling
- FIFO Queue provides O(1) operations for FCFS and Round Robin

== Future Improvements

- Add aging mechanism to prevent starvation in Priority Scheduling
- Implement multi-level feedback queues
- Add process I/O burst simulation
- Calculate and display CPU utilization

#pagebreak()

= References

1. Silberschatz, A., Galvin, P. B., & Gagne, G. (2018). *Operating System Concepts* (10th ed.). Wiley.

2. Tanenbaum, A. S., & Bos, H. (2014). *Modern Operating Systems* (4th ed.). Pearson.

3. Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2009). *Introduction to Algorithms* (3rd ed.). MIT Press.
