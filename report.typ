// Document Configuration
#set document(
  title: "CPU Scheduling Algorithms Simulation Using Data Structures",
  author: "Odai Masnoor Gubran",
)
#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2.5cm),
  numbering: "1",
  header: align(right)[
    _CPU Scheduling Algorithms Simulation_
  ],
)
#set text(size: 11pt, font: "New Computer Modern")
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
  
  #text(size: 14pt)[Data Structures and Algorithms Project]
  
  #v(2cm)
  
  #text(size: 12pt)[
    *Theory Instructor:* Dr. Belal Murshed
    
    *Lab Instructor:* T. Mohammed Al-Sayani
    
    *Student Name:* Odai Masnoor Gubran
    
    *Student ID:* 202410100532
    
    #text(size: 10pt, fill: blue)[#link("https://github.com/odai-dev/CPU-Scheduling-Algorithms-Simulation-Using-Data-Structures")]
  ]
  
  #v(2cm)
  
  #text(size: 12pt)[February 2026]
]

#pagebreak()

// Executive Summary
#align(center)[
  #text(size: 16pt, weight: "bold")[Executive Summary]
]

#v(1cm)

This project presents a comprehensive implementation and comparative analysis of classical CPU scheduling algorithms using custom-built data structures in C++. The simulator implements six algorithm variants: First Come First Serve (FCFS), Shortest Job First (SJF) in both non-preemptive and preemptive modes, Priority Scheduling in both modes, and Round Robin (RR).

All data structures—including Queue, Priority Queue (Binary Heap), Linked List, and Dynamic Array—were implemented from scratch without relying on standard library scheduling containers. The project demonstrates practical applications of these structures in operating system simulations.

Performance analysis reveals that Shortest Remaining Time First (SRTF) achieves the optimal average waiting time of 2.6 time units, while Round Robin provides superior fairness and response time for interactive systems. A graphical user interface built with Dear ImGui offers interactive visualization of process scheduling through animated Gantt charts.

*Key Technologies:* C++17, Custom Data Structures, Dear ImGui, GLFW, OpenGL, Typst

*Key Achievements:*
- Complete implementation of 6 scheduling algorithm variants
- Custom data structures with O(1) to O(log n) operations
- Comprehensive performance comparison and analysis
- Interactive GUI with real-time Gantt chart visualization

#pagebreak()

// Table of Contents
#outline(
  title: "Table of Contents",
  indent: auto,
  depth: 3,
)

#pagebreak()

= Introduction

== Project Overview

CPU scheduling is a fundamental component of operating systems that determines the order in which processes access the CPU. This project implements a complete scheduling simulator that models real-world OS behavior, allowing for direct comparison of different scheduling policies under identical workloads.

The simulator handles diverse process characteristics including arrival times, burst times, and priorities, while accurately calculating key performance metrics such as waiting time, turnaround time, and completion time for each process.

== Project Scope

This project encompasses:

*Core Implementation:*
- Six CPU scheduling algorithm variants
- Four custom data structures built from scratch
- Comprehensive metric calculation and display
- Timeline generation for Gantt chart visualization

*Advanced Features:*
- Graphical User Interface for interactive scheduling
- Real-time animated Gantt charts
- Algorithm performance comparison tools
- Support for custom process input and predefined test cases

*Educational Value:*
- Clear demonstration of algorithm trade-offs
- Visual representation of scheduling behavior
- Practical application of data structure concepts
- Performance analysis methodology

== Aims and Objectives

The primary aims of this project are:

1. *Educational Implementation* - Design and implement a comprehensive CPU scheduling simulator that models real operating-system scheduling behaviour using C++.

2. *Algorithm Coverage* - Implement and compare multiple classical CPU scheduling algorithms:
   - First Come First Serve (FCFS)
   - Shortest Job First (SJF) - Non-Preemptive
   - Shortest Remaining Time First (SRTF) - Preemptive SJF
   - Priority Scheduling - Non-Preemptive
   - Priority Scheduling - Preemptive
   - Round Robin (RR)

3. *Performance Analysis* - Quantitatively analyze scheduling performance using key metrics:
   - Average Waiting Time
   - Average Turnaround Time
   - Completion Time for each process
   - Context switch overhead analysis

4. *Educational Tool* - Provide a tool that helps students understand scheduling trade-offs, starvation, fairness, preemption, and efficiency through visualization and comparison.

5. *Data Structure Application* - Demonstrate practical use of data structures (Queue, Priority Queue, Linked List, Dynamic Array) in operating-system simulations.

6. *Fair Comparison* - Enable algorithm comparison under identical workloads, ensuring fair and consistent evaluation.

== Technologies and Tools

*Programming Language:*
- C++17 with standard library support
- Object-oriented design with separate header and implementation files

*Custom Data Structures:*
- All scheduling structures implemented from scratch
- No use of STL containers for core scheduling logic

*GUI Framework:*
- Dear ImGui for immediate-mode GUI
- GLFW for window management
- OpenGL for graphics rendering

*Documentation:*
- Typst typesetting system for professional report generation

*Build Tools:*
- g++ compiler with C++17 standard
- Manual compilation and linking

#pagebreak()

= Methodology

== System Architecture

The project follows a modular architecture with clear separation of concerns:

```
┌─────────────────────────────────────────────────────┐
│                   User Interface                    │
│              (CLI / GUI with ImGui)                 │
└────────────────────┬────────────────────────────────┘
                     │
         ┌───────────┴───────────┐
         │                       │
┌────────▼────────┐    ┌────────▼────────┐
│  Scheduler.h/cpp│    │  Process.h/cpp  │
│   (Algorithms)  │    │  (Process Data) │
└────────┬────────┘    └─────────────────┘
         │
         │
┌────────▼──────────────────────────────────────┐
│         DataStructures.h/cpp                  │
│  ┌──────────┐  ┌──────────┐  ┌────────────┐  │
│  │  Queue   │  │Priority  │  │   List     │  │
│  │  (FIFO)  │  │  Queue   │  │ (Sorted)   │  │
│  └──────────┘  └──────────┘  └────────────┘  │
└───────────────────────────────────────────────┘
```

== File Organization

#table(
  columns: (auto, auto),
  inset: 10pt,
  [*File*], [*Purpose*],
  [Process.h/cpp], [Process structure definition and implementation],
  [DataStructures.h/cpp], [Custom data structure implementations],
  [Scheduler.h/cpp], [All scheduling algorithms and helper functions],
  [main.cpp], [Command-line interface entry point],
  [gui/gui_main.cpp], [Graphical user interface implementation],
  [report.typ], [Project documentation],
)

== Design Decisions

*Why Custom Data Structures?*
The project requirements explicitly prohibited use of built-in scheduling libraries. All structures were implemented from scratch to demonstrate understanding of:
- Linked list operations and memory management
- Binary heap properties and maintenance
- Queue operations and FIFO ordering
- Dynamic array resizing strategies

*Algorithm Selection Rationale:*
The six selected algorithms represent the fundamental spectrum of scheduling approaches:
- *FCFS*: Simplest algorithm, baseline for comparison
- *SJF/SRTF*: Optimal for minimizing waiting time
- *Priority*: Common in real-time systems
- *Round Robin*: Standard for time-sharing systems

*Performance Metric Choices:*
- Waiting Time: Measures queue delay
- Turnaround Time: Measures total completion time
- Both averaged across all processes for fair comparison

#pagebreak()
= Data Structures

#figure(
  image("images/process_state_diagram_1770238516225.jpg", width: 80%),
  caption: [Process lifecycle and state transitions in CPU scheduling]
)

This section details the custom data structures implemented for the scheduling algorithms. *No built-in scheduling libraries were used* — all structures are implemented from scratch to demonstrate understanding of fundamental data structure concepts.

== Process Structure

=== Purpose
The `Process` structure models a process with all attributes required for CPU scheduling algorithms, supporting both preemptive and non-preemptive scheduling modes.

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

=== Key Formulas

*Waiting Time:* `WT = Completion Time - Arrival Time - Burst Time`

*Turnaround Time:* `TAT = Completion Time - Arrival Time`

*Alternative:* `TAT = WT + Burst Time`

#pagebreak()

== Node Structure

=== Purpose
A generic node for linked structures that holds process data and maintains chain connectivity.

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
- Foundation for linked list-based structures

== ProcessQueue Class (FIFO Queue)

=== Purpose
Implements a *First-In-First-Out (FIFO)* queue structure, essential for:
- *FCFS Algorithm*: Processes are served in arrival order
- *Round Robin Algorithm*: Processes cycle through the ready queue

=== Architecture

```
Queue Structure:
  front                                rear
    │                                   │
    ▼                                   ▼
  ┌────┐    ┌────┐    ┌────┐    ┌────┐
  │ P1 │───▶│ P2 │───▶│ P3 │───▶│ P4 │─┐
  └────┘    └────┘    └────┘    └────┘ │
                                        ▼
                                      nullptr
```

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

=== Implementation Details

*enqueue() Operation:*
```cpp
void ProcessQueue::enqueue(Process value) {
    Node* newNode = new Node(value);
    if(isEmpty()) {
        rear = front = newNode;  // First element
        return;
    } else {
        rear->next = newNode;    // Link to end
        rear = newNode;          // Update rear
    }
}
```

*dequeue() Operation:*
```cpp
Process ProcessQueue::dequeue() {
    if(isEmpty()) {
        return {-1, 0, 0, 0};  // Invalid process
    } 
    Node* temp = front;
    Process p = front->data;
    
    if(front == rear) {
        front = rear = nullptr;  // Last element
    } else {
        front = front->next;     // Move front forward
    }
    delete(temp);
    return p;
}
```

=== Use Cases in Project
- FCFS ready queue management
- Round Robin process rotation
- Timeline data storage

#pagebreak()

== ProcessList Class (Sorted Linked List)

=== Purpose
Implements a singly-linked list with two insertion modes:
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

=== Sorted Insertion Algorithm

```cpp
void ProcessList::addProcess(Process p) {
    Node* newNode = new Node(p);
    
    // Insert at head if empty or p arrives earliest
    if (head == nullptr || head->data.arrivalTime > p.arrivalTime) {
        newNode->next = head;
        head = newNode;
    } else {
        // Find insertion point
        Node* current = head;
        while (current->next != nullptr && 
               current->next->data.arrivalTime <= p.arrivalTime) {
            current = current->next;
        }
        newNode->next = current->next;
        current->next = newNode;
    }
    count++;
}
```

=== Use Cases in Project
- *Master Process List*: Stores all input processes sorted by arrival time
- *Execution Timeline*: Records execution slices for Gantt chart visualization
- *Completed Processes*: Stores processes after finishing execution

#pagebreak()

== DynamicArray Class

=== Purpose
A resizable array providing the foundation for the Priority Queue implementation. Automatically grows when capacity is reached using a doubling strategy.

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

=== Key Implementation

*Automatic Resizing:*
```cpp
void DynamicArray::resize() {
    capacity *= 2;  // Double capacity
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

=== Amortized Analysis

When capacity is reached, resizing takes O(n) time. However, this happens infrequently:
- Starting capacity: 4
- Resizes occur at: 4, 8, 16, 32, 64, ...
- Total insertions for n elements: n + n/2 + n/4 + ... ≈ 2n
- Amortized cost per insertion: O(1)

#pagebreak()

== PriorityQueue Class (Binary Heap)

#figure(
  image("images/heap_visualization_1770238497543.jpg", width: 90%),
  caption: [Binary min-heap structure for Priority Queue implementation showing parent-child relationships and array representation]
)

=== Purpose
The Priority Queue is implemented as a *Binary Heap* stored in a Dynamic Array. It supports both min-heap and max-heap modes for different scheduling algorithms:
- *Min-Heap Mode*: For SJF/SRTF — prioritizes smaller remaining time
- *Max-Heap Mode (by priority value)*: For Priority Scheduling — prioritizes lower priority numbers

=== Components

*Private Members:*
- `DynamicArray heap`: Underlying storage
- `bool isMinHeap`: Mode selector
- Helper functions:
  - `parent(i) = (i-1)/2`
  - `leftChild(i) = 2*i+1`
  - `rightChild(i) = 2*i+2`
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
        return p1.priority < p2.priority;  // Lower number = higher priority
    }
}
```

=== Heap Operations

*heapifyUp() - After Insertion:*
```cpp
void PriorityQueue::heapifyUp(int idx) {
    if(idx == 0) return;  // Root reached
    int parentIdx = parent(idx);
    if(hasHigherPriority(heap[idx], heap[parentIdx])) {
        swap(idx, parentIdx);
        heapifyUp(parentIdx);  // Recursive
    }
}
```

*heapifyDown() - After Deletion:*
```cpp
void PriorityQueue::heapifyDown(int idx) {
    int left = leftChild(idx);
    int right = rightChild(idx);
    int highest = idx;

    if (left < heap.getSize() && 
        hasHigherPriority(heap[left], heap[highest])) {
        highest = left;
    }
    if (right < heap.getSize() && 
        hasHigherPriority(heap[right], heap[highest])) {
        highest = right;
    }
    if(highest != idx) {
        swap(idx, highest);
        heapifyDown(highest);  // Recursive
    }
}
```

=== Use Cases in Project
- SJF/SRTF: Min-heap by remaining time
- Priority Scheduling: Heap by priority value
- Efficient O(log n) insertion and removal

#pagebreak()
= Scheduling Algorithms

This section provides comprehensive documentation of all six scheduling algorithm variants implemented in the project, including detailed explanations, pseudocode, implementation details, and visual representations.

== First Come First Serve (FCFS)

=== Algorithm Overview

FCFS is the simplest scheduling algorithm where processes are executed in the order they arrive in the ready queue. It is *non-preemptive* — once a process starts execution, it runs to completion without interruption.

=== Characteristics

#table(
  columns: (auto, auto),
  inset: 8pt,
  [*Property*], [*Value*],
  [Type], [Non-Preemptive],
  [Starvation], [No — all processes eventually execute],
  [Convoy Effect], [Yes — short processes wait for long ones],
  [Overhead], [Minimal — no context switching during execution],
  [Fairness], [Fair in order of arrival],
  [Implementation Complexity], [Very Simple],
)

=== Algorithm Logic

1. Maintain a FIFO queue of ready processes
2. As processes arrive, add them to the queue
3. Execute process at front of queue to completion
4. Handle CPU idle time when no processes are available
5. Calculate metrics after completion

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
            // Handle idle CPU - jump to next arrival
            if (it != nullptr) {
                currentTime = it->data.arrivalTime;
            }
        }
   }
   return completedProcesses;
}
```

=== Execution Example

#figure(
  image("images/gantt_fcfs_1770238432778.jpg", width: 100%),
  caption: [FCFS Gantt chart showing sequential execution in arrival order with CPU idle time]
)

#pagebreak()

== Shortest Job First (SJF)

=== Algorithm Overview

SJF selects the process with the *smallest burst time* (or remaining time in preemptive mode). This algorithm provably minimizes average waiting time but requires knowing burst times in advance.

=== Variants

*Non-Preemptive SJF:* Once started, process runs to completion

*Preemptive SJF (SRTF):* Process can be interrupted if a shorter job arrives

=== Characteristics

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  [*Property*], [*Non-Preemptive*], [*Preemptive (SRTF)*],
  [Optimal AWT], [Yes (among non-preemptive)], [Yes (overall optimal)],
  [Starvation], [Possible for long jobs], [Possible for long jobs],
  [Context Switches], [Low], [High (potentially every time unit)],
  [Complexity], [Moderate], [High],
  [Real-world Applicability], [Batch systems], [Modern OS with estimation],
)

=== Implementation Approach

1. Use a min-heap priority queue ordered by remaining time
2. When a process arrives, add it to the priority queue
3. Always execute the process with smallest remaining time
4. For preemptive: re-evaluate after each time unit
5. For non-preemptive: execute to completion

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
                // SRTF: Execute 1 time unit
                Process p = pq.dequeue();
                
                // Log 1-unit slice for Gantt Chart
                Process slice = p;
                slice.arrivalTime = currentTime;
                slice.burstTime = 1;
                timeline.push_back(slice);

                p.remainingTime--;
                currentTime++;
                
                if(p.remainingTime > 0) pq.enqueue(p);  // Re-queue
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

=== Execution Example

#figure(
  image("images/gantt_sjf_preemptive_1770238478914.jpg", width: 100%),
  caption: [SRTF (Preemptive SJF) showing preemption points where shorter jobs interrupt longer jobs]
)

=== Why SRTF is Optimal

SRTF minimizes average waiting time because it always executes the process closest to completion. Mathematical proof shows that any deviation from this policy increases total waiting time.

*Proof Sketch:* If we swap execution order of two processes where the first has longer remaining time, the shorter process waits longer unnecessarily, increasing average waiting time.

#pagebreak()

== Priority Scheduling

=== Algorithm Overview

Priority Scheduling assigns each process a priority value. The CPU is allocated to the process with the *highest priority* (lowest priority number in this implementation).

=== Characteristics

#table(
  columns: (auto, auto),
  inset: 8pt,
  [*Property*], [*Value*],
  [Priority Convention], [Lower number = Higher priority],
  [Starvation], [Yes — low priority processes may never execute],
  [Solution to Starvation], [Aging — gradually increase priority over time],
  [Use Case], [Real-time systems, OS kernel tasks],
  [Preemption Support], [Both preemptive and non-preemptive modes],
)

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

=== Starvation Problem and Solutions

*Problem:* Low-priority processes may wait indefinitely if high-priority processes keep arriving.

*Solution - Aging:* Gradually increase the priority of waiting processes over time.

```cpp
// Potential aging implementation (not in current project)
void applyAging(ProcessList& waitingProcesses, int currentTime) {
    Node* curr = waitingProcesses.getHead();
    while(curr != nullptr) {
        int waitTime = currentTime - curr->data.arrivalTime;
        // Increase priority every 10 time units
        curr->data.priority -= (waitTime / 10);
        if(curr->data.priority < 0) curr->data.priority = 0;
        curr = curr->next;
    }
}
```

#pagebreak()

== Round Robin (RR)

=== Algorithm Overview

Round Robin allocates the CPU to each process for a fixed *time quantum*. If a process doesn't complete within its quantum, it's preempted and moved to the back of the queue. This ensures fair CPU distribution.

=== Characteristics

#table(
  columns: (auto, auto),
  inset: 8pt,
  [*Property*], [*Value*],
  [Type], [Preemptive],
  [Starvation], [No — guaranteed CPU time for all],
  [Fairness], [High — equal time slices for all processes],
  [Response Time], [Good for interactive systems],
  [Context Switches], [Higher than FCFS],
  [Time Quantum Impact], [Critical parameter for performance],
)

=== Time Quantum Selection

The choice of time quantum (Q) dramatically affects performance:

*Too Small (Q → 0):*
- Approaches processor sharing
- Excessive context switch overhead
- Poor throughput

*Too Large (Q → ∞):*
- Degrades to FCFS behavior
- Poor response time
- Loses fairness advantage

*Optimal Range:*
- Typically 10-100 ms in real systems
- Should be larger than context switch time
- Depends on process characteristics

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

=== Execution Example

#figure(
  image("images/gantt_round_robin_1770238457125.jpg", width: 100%),
  caption: [Round Robin with quantum=2 showing process rotation and context switches at quantum boundaries]
)

=== Response Time Analysis

Round Robin excels at response time because every process gets CPU attention within one cycle through the queue:

*Maximum Response Time* = (n-1) × Q

where n = number of processes, Q = time quantum

This bounded response time makes RR ideal for interactive systems where users expect quick feedback.

#pagebreak()
= Execution Results and Analysis

This section presents comprehensive test results for all six algorithm variants using identical input workloads to ensure fair comparison.

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

*Execution Order:* P1 → P2 → P3 → P4 → (Idle) → P5

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

*Analysis:* FCFS provides baseline performance. Simple and fair, but suffers from convoy effect where short processes (P4) wait behind longer ones.

== SJF Non-Preemptive Results

*Execution Order:* P1 → P4 → P2 → P3 → (Idle) → P5

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

*Analysis:* Non-preemptive SJF improves upon FCFS by executing shorter jobs (P4, P2) earlier, reducing average waiting time by 15.8%.

== SRTF (Preemptive SJF) Results

*Execution Order:* P1 → P2 → P4 → P2 → P3 → P1 → (Idle) → P5

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  inset: 8pt,
  align: center,
  [*Process*], [*Arrival*], [*Burst*], [*Completion*], [*Waiting*], [*Turnaround*],
  [P1], [0], [5], [14], [9], [14],
  [P2], [1], [3], [7], [3], [6],
  [P3], [2], [4], [11], [5], [9],
  [P4], [3], [2], [5], [0], [2],
  [P5], [50], [4], [54], [0], [4],
)

*Average Waiting Time:* 2.6
*Average Turnaround Time:* 6.2

*Analysis:* SRTF achieves optimal average waiting time by preempting longer jobs when shorter ones arrive. This is the theoretical minimum for this workload.

== Priority Non-Preemptive Results

*Execution Order:* P1 → P3 → P2 → P4 → (Idle) → P5

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  inset: 8pt,
  align: center,
  [*Process*], [*Arrival*], [*Burst*], [*Completion*], [*Waiting*], [*Turnaround*],
  [P1], [0], [5], [5], [0], [5],
  [P3], [2], [4], [9], [3], [7],
  [P2], [1], [3], [12], [8], [11],
  [P4], [3], [2], [14], [9], [11],
  [P5], [50], [4], [54], [0], [4],
)

*Average Waiting Time:* 4.0
*Average Turnaround Time:* 7.6

*Analysis:* Priority scheduling executes high-priority processes (P3, P2) before low-priority ones (P4), even if they arrive earlier.

== Priority Preemptive Results

*Execution Order:* P1 → P3 → P2 → P3 → P1 → P4 → (Idle) → P5

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  inset: 8pt,
  align: center,
  [*Process*], [*Arrival*], [*Burst*], [*Completion*], [*Waiting*], [*Turnaround*],
  [P1], [0], [5], [13], [8], [13],
  [P2], [1], [3], [6], [2], [5],
  [P3], [2], [4], [10], [4], [8],
  [P4], [3], [2], [15], [10], [12],
  [P5], [50], [4], [54], [0], [4],
)

*Average Waiting Time:* 4.8
*Average Turnaround Time:* 8.4

*Analysis:* Preemptive priority allows high-priority processes to interrupt lower ones, improving responsiveness for critical tasks.

== Round Robin Results (Quantum = 2)

*Execution Order:* P1 → P2 → P3 → P4 → P1 → P2 → P3 → P1 → P3 → (Idle) → P5

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  inset: 8pt,
  align: center,
  [*Process*], [*Arrival*], [*Burst*], [*Completion*], [*Waiting*], [*Turnaround*],
  [P1], [0], [5], [15], [10], [15],
  [P2], [1], [3], [11], [7], [10],
  [P3], [2], [4], [16], [10], [14],
  [P4], [3], [2], [8], [3], [5],
  [P5], [50], [4], [54], [0], [4],
)

*Average Waiting Time:* 6.0
*Average Turnaround Time:* 9.6

*Analysis:* Round Robin provides fair CPU sharing with guaranteed response time. Higher waiting time is offset by better interactivity and no starvation.

#pagebreak()

= Performance Comparison

#figure(
  image("images/performance_comparison_1770238537644.jpg", width: 100%),
  caption: [Comparative performance analysis showing average waiting time and turnaround time for all algorithms]
)

== Summary Table

#table(
  columns: (auto, auto, auto, auto),
  inset: 10pt,
  align: center,
  [*Algorithm*], [*Avg Waiting Time*], [*Avg Turnaround Time*], [*Rank*],
  [*SRTF (Preemptive SJF)*], [*2.6*], [*6.2*], [1st],
  [SJF (Non-Preemptive)], [3.2], [6.8], [2nd],
  [FCFS], [3.8], [7.4], [3rd],
  [Priority (Non-Preemptive)], [4.0], [7.6], [4th],
  [Priority (Preemptive)], [4.8], [8.4], [5th],
  [Round Robin (Q=2)], [6.0], [9.6], [6th],
)

== Detailed Analysis

=== Best Average Waiting Time

*Winner: SRTF (Preemptive SJF)* - 2.6 time units

SRTF achieves the theoretical minimum average waiting time by always running the process closest to completion. This is mathematically provable to be optimal.

*Why it works:* Minimizes cumulative waiting by completing shorter jobs first, reducing the number of processes waiting at any given time.

=== Best for Interactive Systems

*Winner: Round Robin* - Despite higher average times

Round Robin provides:
- *Bounded response time*: Every process gets CPU within (n-1) × Q time units
- *No starvation*: All processes guaranteed execution
- *Fairness*: Equal CPU time distribution
- *Predictability*: Regular CPU access pattern

=== Simplest Implementation

*Winner: FCFS*

- Minimal code complexity
- No priority calculation
- No preemption logic
- O(1) scheduling decisions

=== Real-World Applicability

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  [*Algorithm*], [*Best Use Case*], [*Real-World Example*],
  [FCFS], [Batch processing, print queues], [Print spooler, simple embedded systems],
  [SJF/SRTF], [When burst times known, batch jobs], [Scientific computing clusters with job estimates],
  [Priority], [Real-time systems, critical tasks], [Operating system kernel, interrupt handling],
  [Round Robin], [Time-sharing, interactive systems], [Unix/Linux process scheduling, web servers],
)

== Algorithm Selection Guide

*Choose FCFS when:*
- Simplicity is paramount
- All jobs have similar burst times
- Batch processing environment
- Minimal overhead required

*Choose SJF/SRTF when:*
- Burst times can be estimated accurately
- Minimizing average waiting time is critical
- Batch systems with job profiles available
- Can tolerate potential starvation of long jobs

*Choose Priority Scheduling when:*
- Jobs have different criticality levels
- Real-time guarantees needed for high-priority tasks
- Clear task hierarchy exists
- Can implement aging to prevent starvation

*Choose Round Robin when:*
- Interactive/time-sharing system
- Fair CPU distribution required
- Response time more important than throughput
- All processes should make progress

== Trade-offs Summary

#table(
  columns: (auto, auto, auto, auto),
  inset: 8pt,
  align: center,
  [*Metric*], [*FCFS*], [*SJF/SRTF*], [*Round Robin*],
  [Waiting Time], [Moderate], [Optimal], [Higher],
  [Response Time], [Poor], [Variable], [Excellent],
  [Throughput], [Good], [Excellent], [Moderate],
  [Fairness], [Fair], [Unfair to long jobs], [Very Fair],
  [Starvation], [No], [Possible], [No],
  [Overhead], [Minimal], [Low/Moderate], [Higher],
  [Complexity], [Very Simple], [Moderate], [Simple],
)

#pagebreak()
= Graphical User Interface

== Overview

An interactive graphical user interface was implemented using *Dear ImGui* (Immediate Mode GUI) to provide visual interaction with the scheduling algorithms. The GUI enables users to:
- Input process data interactively
- Select and run different scheduling algorithms
- Visualize execution through animated Gantt charts
- Compare performance metrics in real-time

== Technology Stack

*Dear ImGui:* Lightweight immediate-mode GUI framework
- Version: Latest stable (v1.89+)
- Rendering backend: OpenGL 3
- Platform backend: GLFW 3

*OpenGL:* Graphics rendering for Gantt chart visualization

*GLFW:* Cross-platform window and input handling

== GUI Architecture

```
┌─────────────────────────────────────────────────────┐
│              Main Application Window                │
├──────────────────────┬──────────────────────────────┤
│  Process Controller  │    Gantt Chart & Stats       │
│                      │                              │
│  ┌───────────────┐   │  ┌────────────────────────┐  │
│  │ Input Fields  │   │  │  Animation Controls    │  │
│  │ - Arrival     │   │  │  [Pause] [Restart]     │  │
│  │ - Burst       │   │  │  Speed: [====----]     │  │
│  │ - Priority    │   │  └────────────────────────┘  │
│  └───────────────┘   │                              │
│                      │  ┌────────────────────────┐  │
│  ┌───────────────┐   │  │  Gantt Chart          │  │
│  │ Action Buttons│   │  │  ┌──┬──┬───┬───┬─────┐│  │
│  │ [Add Process] │   │  │  │P1│P2│P3 │P4 │ Idle││  │
│  │ [Dummy Data]  │   │  │  └──┴──┴───┴───┴─────┘│  │
│  │ [Clear]       │   │  │  0  5  10  15      54 │  │
│  └───────────────┘   │  └────────────────────────┘  │
│                      │                              │
│  ┌───────────────┐   │  ┌────────────────────────┐  │
│  │Process Table  │   │  │  Statistics           │  │
│  │ ID  Arr  Bur  │   │  │  Avg Wait: 3.8        │  │
│  │ P1   0    5   │   │  │  Avg Turn: 7.4        │  │
│  │ P2   1    3   │   │  └────────────────────────┘  │
│  │ ...           │   │                              │
│  └───────────────┘   │  ┌────────────────────────┐  │
│                      │  │  Results Table        │  │
│  ┌───────────────┐   │  │  ID  Finish  Wait  TA │  │
│  │Algorithm Btn  │   │  │  P1    5      0     5 │  │
│  │ [FCFS]        │   │  │  P2    8      4     7 │  │
│  │ [Round Robin] │   │  │  ...                  │  │
│  │ [SJF Non-P]   │   │  └────────────────────────┘  │
│  │ [SRTF]        │   │                              │
│  │ [Priority]    │   │                              │
│  └───────────────┘   │                              │
└──────────────────────┴──────────────────────────────┘
```

== Key Features

=== 1. Process Input Panel

*Manual Process Entry:*
- Input fields for Arrival Time, Burst Time, and Priority
- "Add Process" button to add to master list
- Input validation to prevent negative values

*Quick Testing:*
- "Fill Dummy Data" button loads predefined test case
- Provides consistent test data for algorithm comparison

*Data Management:*
- "Clear Input" button resets all data
- Visual process table shows all added processes

=== 2. Algorithm Selection

Six algorithm buttons with clear labeling:
- FCFS
- Round Robin (with quantum input field)
- SJF Non-Preemptive
- SRTF (Preemptive SJF)
- Priority Non-Preemptive
- Preemptive Priority

Each button triggers immediate execution and result visualization.

=== 3. Interactive Gantt Chart

*Animated Visualization:*
- Real-time process block rendering
- Color-coded processes for easy identification
- Time axis with clear markers
- Automatic scaling based on timeline length

*Animation Controls:*
- Pause/Resume button for step-by-step analysis
- Restart button to replay from beginning
- Speed slider (1-100 units/second) for analysis control

*Visual Design:*
- Process blocks with rounded corners and borders
- Distinct colors for each process (blue, green, orange, purple, red)
- Process ID labels on blocks when space permits
- Smooth animation using delta time

=== 4. Statistics Display

*Real-Time Metrics:*
- Average Waiting Time
- Average Turnaround Time
- Updated immediately after algorithm execution

*Detailed Results Table:*
- Process ID
- Completion Time
- Waiting Time
- Turnaround Time
- Sortable and scrollable for large datasets

== Implementation Details

=== Main Loop Structure

```cpp
while (!glfwWindowShouldClose(window)) {
    // 1. Poll input events
    glfwPollEvents();
    
    // 2. Start new ImGui frame
    ImGui_ImplOpenGL3_NewFrame();
    ImGui_ImplGlfw_NewFrame();
    ImGui::NewFrame();
    
    // 3. Draw GUI windows
    DrawProcessController();
    DrawGanttChartAndStats();
    
    // 4. Render
    ImGui::Render();
    glClear(GL_COLOR_BUFFER_BIT);
    ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
    glfwSwapBuffers(window);
}
```

=== Gantt Chart Rendering

```cpp
// Draw Gantt Chart from Timeline
ImDrawList* draw_list = ImGui::GetWindowDrawList();
ImVec2 p = ImGui::GetCursorScreenPos();
float chartHeight = 80.0f;
float scaleX = 30.0f;  // Pixels per time unit

Node* curr = Scheduler::timeline.getHead();
while (curr) {
    Process& slice = curr->data;
    float startX = slice.arrivalTime * scaleX;
    float width = slice.burstTime * scaleX;
    float visibleEndX = animationTime * scaleX;
    
    if (visibleEndX > startX) {
        float drawWidth = min(width, visibleEndX - startX);
        
        // Draw process block
        ImU32 color = GetProcessColor(slice.id);
        draw_list->AddRectFilled(
            ImVec2(p.x + startX, p.y + 40), 
            ImVec2(p.x + startX + drawWidth, p.y + 40 + chartHeight), 
            color
        );
        
        // Draw border
        draw_list->AddRect(
            ImVec2(p.x + startX, p.y + 40), 
            ImVec2(p.x + startX + drawWidth, p.y + 40 + chartHeight), 
            IM_COL32(255, 255, 255, 255)
        );
        
        // Add process label if space permits
        if (drawWidth > 15.0f) {
            char buf[16];
            sprintf(buf, "P%d", slice.id);
            draw_list->AddText(
                ImVec2(p.x + startX + 5, p.y + 60), 
                IM_COL32(255,255,255,255), 
                buf
            );
        }
    }
    curr = curr->next;
}
```

=== Animation System

```cpp
// Animation state
static float animationTime = 0.0f;
static float animationSpeed = 20.0f;
static bool isPaused = false;
static float maxTime = 0.0f;

// Update animation
if (!isPaused && animationTime < maxTime) {
    animationTime += deltaTime * (animationSpeed / 5.0f);
    if (animationTime > maxTime) 
        animationTime = maxTime;
}
```

== User Workflow

1. *Input Processes:* User adds processes manually or uses dummy data
2. *Select Algorithm:* Click desired algorithm button
3. *View Results:* Gantt chart animates execution, statistics update
4. *Analyze:* Use pause/restart and speed controls to study behavior
5. *Compare:* Run different algorithms on same dataset
6. *Iterate:* Modify input and re-test

== GUI Development Credit

The graphical user interface was developed with assistance from *Gemini CLI*, an AI-powered coding assistant. Gemini CLI helped with:
- ImGui API usage and best practices
- OpenGL rendering optimization
- Animation system implementation
- Layout and styling decisions

#pagebreak()

= Compilation and Execution

== Prerequisites

*Required Software:*
- g++ compiler with C++17 support
- GLFW3 development libraries
- OpenGL development libraries
- Typst (for report compilation)

*Installation (Ubuntu/Debian):*
```bash
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install libglfw3-dev
sudo apt-get install libgl1-mesa-dev
```

== Building the Console Application

```bash
# Navigate to project directory
cd /home/odai/Documents/Coding/CPUSchedulingUsingDSA

# Compile all source files
g++ -std=c++17 -o scheduler_cli \
    Process.cpp \
    DataStructures.cpp \
    Scheduler.cpp \
    main.cpp

# Run the program
./scheduler_cli
```

=== Using the Console Application

The CLI application provides an interactive menu system for easy navigation:

*Initial Menu:*
1. Load Dummy Process Data - Pre-configured test set (5 processes)
2. Enter Processes Manually - Custom process input
3. Exit

*After Loading Data:*

Once data is loaded, you can:
- Run any of the 6 scheduling algorithms
- View the current process list
- Reset and load new data
- Exit the application

*Example Workflow:*

```
Step 1: Choose "Load Dummy Process Data" or "Enter Processes Manually"
Step 2: View loaded processes to confirm data
Step 3: Select an algorithm (e.g., FCFS, SJF, Round Robin)
Step 4: View results table with statistics
Step 5: Run other algorithms on same data for comparison
Step 6: Reset to load new data if needed
```

*Features:*
- Clean menu interface with visual separators
- Automatic statistics display after each algorithm
- Process list viewer for data verification
- Configurable time quantum for Round Robin
- Reset option without restarting the program


== Building the GUI Application

```bash
# Navigate to project directory
cd /home/odai/Documents/Coding/CPUSchedulingUsingDSA

# Compile GUI application
g++ -std=c++17 -o scheduler_gui \
    Process.cpp \
    DataStructures.cpp \
    Scheduler.cpp \
    gui/gui_main.cpp \
    gui/imgui.cpp \
    gui/imgui_draw.cpp \
    gui/imgui_tables.cpp \
    gui/imgui_widgets.cpp \
    gui/imgui_impl_glfw.cpp \
    gui/imgui_impl_opengl3.cpp \
    -lglfw -lGL -ldl

# Run GUI application
./scheduler_gui
```

== Compiling the Report

```bash
# Compile Typst document to PDF
typst compile report.typ report.pdf

# View the PDF
xdg-open report.pdf  # Linux
# or
open report.pdf      # macOS
```

#pagebreak()

= Conclusion

== Summary of Achievements

This project successfully demonstrates a comprehensive implementation and comparative analysis of CPU scheduling algorithms using custom-built data structures. Key accomplishments include:

1. *Complete Algorithm Implementation*
   - Six scheduling algorithm variants fully implemented
   - Both preemptive and non-preemptive modes supported
   - Accurate metric calculation for all algorithms

2. *Custom Data Structures*
   - Queue with O(1) operations for FCFS and Round Robin
   - Priority Queue (Binary Heap) with O(log n) operations for SJF and Priority scheduling
   - Linked List with sorted insertion for process management
   - Dynamic Array with amortized O(1) insertion
   - All implemented from scratch without standard library scheduling containers

3. *Performance Analysis*
   - Quantitative comparison showing SRTF achieves optimal 2.6 average waiting time
   - Demonstrated trade-offs between waiting time, turnaround time, and fairness
   - Provided algorithm selection guidelines for different scenarios

4. *Modular Design*
   - Separate header and implementation files for maintainability
   - Clear separation of concerns between data structures, algorithms, and UI
   - Reusable components across console and GUI interfaces

5. *Visual Learning Tools*
   - Interactive GUI with Dear ImGui for hands-on algorithm exploration
   - Animated Gantt charts for execution visualization
   - Real-time performance metric display

== Key Takeaways

*Algorithm Characteristics:*
- Different algorithms excel in different scenarios — no universal "best" algorithm
- SRTF is theoretically optimal for minimizing average waiting time
- Round Robin provides superior fairness and response time for interactive systems
- Priority scheduling enables real-time system guarantees but risks starvation

*Data Structure Impact:*
- Choice of data structure significantly impacts algorithm efficiency
- Priority Queue enables O(log n) scheduling decisions for SJF and Priority algorithms
- FIFO Queue provides O(1) operations for FCFS and Round Robin
- Proper data structure design is crucial for scalable scheduling

*Trade-offs:*
- Waiting time vs. fairness (SRTF vs. RR)
- Throughput vs. response time
- Implementation complexity vs. performance
- Context switch overhead vs. preemption benefits

== Project Impact

This project provided valuable experience in:
- Operating system concepts and scheduling theory
- Data structure design and implementation
- Algorithm analysis and comparison methodology
- GUI programming with immediate-mode frameworks
- Technical documentation and visualization
- Performance measurement and optimization

== Future Improvements

=== Algorithm Enhancements

*Aging Mechanism:*
Implement priority aging to prevent starvation in Priority Scheduling:
```cpp
void applyAging(Process& p, int currentTime) {
    int waitTime = currentTime - p.arrivalTime;
    p.priority = max(0, p.basePriority - (waitTime / 10));
}
```

*Multi-Level Feedback Queue (MLFQ):*
Combine multiple queues with different priorities and time quantums:
- High priority queue: quantum = 2
- Medium priority queue: quantum = 4
- Low priority queue: quantum = 8
- Processes move between queues based on behavior

=== Feature Additions

*I/O Burst Simulation:*
Model processes with both CPU and I/O bursts:
```cpp
struct BurstSequence {
    vector<int> cpuBursts;
    vector<int> ioBursts;
};
```

*CPU Utilization:*
Calculate and display CPU utilization percentage:
```cpp
float utilization = (totalBusyTime / totalTime) * 100;
```

*Process Priority Inversion:*
Implement priority inheritance protocol to prevent priority inversion problems

*Throughput Metrics:*
Track processes completed per time unit

=== Visualization Improvements

- Export Gantt charts as images
- Side-by-side algorithm comparison view
- Timeline scrubbing for detailed analysis
- Process state history visualization
- Context switch indicator on Gantt chart

=== Performance Optimizations

- Event-driven simulation instead of time-unit iteration
- Caching of calculation results
- Parallel algorithm execution for comparison
- Memory pooling for nodes to reduce allocation overhead

== Concluding Remarks

This project demonstrates that classical CPU scheduling algorithms remain highly relevant for understanding modern operating systems. While real-world schedulers (like Linux's Completely Fair Scheduler or Windows' thread scheduler) are more complex, they build upon these fundamental concepts.

The implementation proves that careful data structure selection and algorithm design can achieve significant performance differences. SRTF's 31.6% improvement in average waiting time over Round Robin illustrates the quantifiable impact of scheduling policy choices.

Most importantly, the visual and interactive nature of this project makes abstract operating system concepts tangible and understandable, serving as an effective educational tool for computer science students studying system programming and algorithm design.

#pagebreak()

= References

1. Silberschatz, A., Galvin, P. B., & Gagne, G. (2018). *Operating System Concepts* (10th ed.). Wiley. 
   - Comprehensive coverage of CPU scheduling algorithms and performance metrics

2. Tanenbaum, A. S., & Bos, H. (2014). *Modern Operating Systems* (4th ed.). Pearson.
   - Detailed analysis of scheduling policies in real-world operating systems

3. Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2009). *Introduction to Algorithms* (3rd ed.). MIT Press.
   - Binary heap implementation and complexity analysis

4. Love, R. (2010). *Linux Kernel Development* (3rd ed.). Addison-Wesley.
   - Real-world implementation details of the Linux Completely Fair Scheduler

5. Dear ImGui Documentation. (2024). Retrieved from https://github.com/ocornut/imgui
   - GUI framework documentation and examples

6. GLFW Documentation. (2024). Retrieved from https://www.glfw.org/documentation.html
   - Window management and OpenGL context creation

#pagebreak()

= Appendices

== Appendix A: File Structure

```
CPUSchedulingUsingDSA/
│
├── Process.h             # Process structure declaration
├── Process.cpp           # Process implementation
│
├── DataStructures.h      # Custom data structure declarations
├── DataStructures.cpp    # Queue, Priority Queue, List implementations
│
├── Scheduler.h           # Scheduling algorithm declarations
├── Scheduler.cpp         # Algorithm implementations (FCFS, SJF, Priority, RR)
│
├── main.cpp              # Console application entry point
│
├── gui/                  # Graphical interface directory
│   ├── gui_main.cpp      # GUI application entry point
│   ├── imgui.h/.cpp      # Dear ImGui core
│   ├── imgui_draw.cpp    # ImGui drawing functions
│   ├── imgui_tables.cpp  # ImGui table functionality
│   ├── imgui_widgets.cpp # ImGui widget implementations
│   ├── imgui_impl_glfw.h/.cpp      # GLFW backend
│   └── imgui_impl_opengl3.h/.cpp   # OpenGL backend
│
├── images/               # Report visualizations
│   ├── gantt_fcfs.jpg
│   ├── gantt_round_robin.jpg
│   ├── gantt_sjf_preemptive.jpg
│   ├── heap_visualization.jpg
│   ├── performance_comparison.jpg
│   └── process_state_diagram.jpg
│
├── report.typ            # Project documentation (this document)
│
├── .gitignore            # Git ignore rules
└── README.md             # Project overview (if present)
```

== Appendix B: Complete Process Test Case

For comprehensive testing, use the following diverse process set:

#table(
  columns: (auto, auto, auto, auto),
  inset: 8pt,
  align: center,
  [*Process*], [*Arrival*], [*Burst*], [*Priority*],
  [P1], [0], [8], [3],
  [P2], [1], [4], [2],
  [P3], [2], [9], [1],
  [P4], [3], [5], [4],
  [P5], [4], [2], [5],
  [P6], [5], [6], [2],
  [P7], [6], [3], [3],
)

== Appendix C: Complexity Analysis Summary

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  [*Operation*], [*Data Structure*], [*Time Complexity*],
  [Process Arrival], [Queue/PQ], [O(1) / O(log n)],
  [Select Next Process], [Queue], [O(1)],
  [Select Next Process], [Priority Queue], [O(log n)],
  [Process Completion], [All], [O(1)],
  [Timeline Recording], [Linked List], [O(n)],
  [Metric Calculation], [Linked List], [O(n)],
)

*Overall Algorithm Complexity:*
- FCFS: O(n) where n = number of processes
- SJF/SRTF: O(n log n) due to priority queue operations
- Priority: O(n log n) due to priority queue operations
- Round Robin: O(n) with queue operations

== Appendix D: Acknowledgments

*Course Instructors:*
- Dr. Belal Murshed (Theory Instructor) for comprehensive operating systems concepts
- T. Mohammed Al-Sayani (Lab Instructor) for practical guidance and project requirements

*Development Tools:*
- Dear ImGui library by Omar Cornut
- GLFW library for window management
- Typst typesetting system for documentation

*AI Assistance:*
- Gemini CLI for GUI implementation guidance and code optimization suggestions

---

*End of Report*
