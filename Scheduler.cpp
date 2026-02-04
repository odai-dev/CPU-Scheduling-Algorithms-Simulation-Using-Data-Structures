#include "Scheduler.h"
#include <iostream>
using namespace std;

ProcessList Scheduler::timeline;

void Scheduler::diplayStats(ProcessList &completedProcesses) {
  Node *current = completedProcesses.getHead();
  int size = completedProcesses.getSize();
  int totalWaitingTime = 0;
  int totalTurnaroundTime = 0;

  cout << "\n=================================================================="
          "================"
       << endl;
  cout << "ID\tArrival\tBurst\t| Finish\tWaiting\t\tTurnaround" << endl;
  cout << "--------------------------------------------------------------------"
          "--------------"
       << endl;

  while (current != nullptr) {
    cout << "P" << current->data.id << "\t" << current->data.arrivalTime << "\t"
         << current->data.burstTime << "\t| " << current->data.completionTime
         << "\t\t" << current->data.waitingTime << "\t\t"
         << current->data.turnaroundTime << endl;

    totalWaitingTime += current->data.waitingTime;
    totalTurnaroundTime += current->data.turnaroundTime;
    current = current->next;
  }
  cout << "--------------------------------------------------------------------"
          "------"
       << endl;

  double AWT = (double)totalWaitingTime / size;
  double ATT = (double)totalTurnaroundTime / size;

  cout << "Average Waiting Time:    " << AWT << endl;
  cout << "Average Turnaround Time: " << ATT << endl;
  cout << "===================================================================="
          "======"
       << endl;
}

ProcessList Scheduler::runFCFS(ProcessList &masterList) {
  ProcessQueue readyQueue;
  int currentTime = 0;
  int completed = 0;
  Node *it = masterList.getHead();
  int total = masterList.getSize();
  ProcessList completedProcesses;
  timeline.clear();

  while (completed < total) {
    // Check Arrival
    while (it != nullptr && it->data.arrivalTime <= currentTime) {
      readyQueue.enqueue(it->data);
      it = it->next;
    }

    // Execution
    if (!readyQueue.isEmpty()) {
      Process p = readyQueue.dequeue();

      // Log for Gantt Chart (using arrivalTime as StartTime for slice,
      // burstTime as Duration)
      Process slice = p;
      slice.arrivalTime = currentTime; // Start Time
      slice.burstTime = p.burstTime;   // Duration
      timeline.push_back(slice);

      p.waitingTime = currentTime - p.arrivalTime;
      currentTime += p.burstTime;
      p.completionTime = currentTime;
      p.turnaroundTime = p.waitingTime + p.burstTime;

      completedProcesses.addProcess(p);
      completed++;
    } else {
      // Handel idle CPU state
      if (it != nullptr) {
        currentTime = it->data.arrivalTime;
      }
    }
  }
  Scheduler::diplayStats(completedProcesses);
  return completedProcesses;
}

ProcessList Scheduler::runSJF(ProcessList &masterList, bool preemptive) {
  PriorityQueue pq(true);
  int currentTime = 0;
  int completed = 0;
  Node *it = masterList.getHead();
  int total = masterList.getSize();
  ProcessList completedProcesses;
  timeline.clear();

  while (completed < total) {
    while (it != nullptr && it->data.arrivalTime <= currentTime) {
      pq.enqueue(it->data);
      it = it->next;
    }

    if (!pq.isEmpty()) {
      if (preemptive) {
        Process p = pq.dequeue();

        // Log 1-unit slice
        Process slice = p;
        slice.arrivalTime = currentTime;
        slice.burstTime = 1;
        timeline.push_back(slice);

        p.remainingTime--;
        currentTime++;
        if (p.remainingTime > 0)
          pq.enqueue(p);
        if (p.remainingTime == 0) {
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
      if (it != nullptr) {
        currentTime = it->data.arrivalTime;
      }
    }
  }
  Scheduler::diplayStats(completedProcesses);
  return completedProcesses;
}

ProcessList Scheduler::runPriority(ProcessList &masterList, bool preemptive) {
  PriorityQueue pq(false);
  int currentTime = 0;
  int completed = 0;
  Node *it = masterList.getHead();
  int total = masterList.getSize();
  ProcessList completedProcesses;
  timeline.clear();

  while (completed < total) {
    while (it != nullptr && it->data.arrivalTime <= currentTime) {
      pq.enqueue(it->data);
      it = it->next;
    }

    if (!pq.isEmpty()) {
      if (preemptive) {
        Process p = pq.dequeue();

        // Log 1-unit slice
        Process slice = p;
        slice.arrivalTime = currentTime;
        slice.burstTime = 1;
        timeline.push_back(slice);

        p.remainingTime--;
        currentTime++;
        if (p.remainingTime > 0)
          pq.enqueue(p);
        if (p.remainingTime == 0) {
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
      if (it != nullptr) {
        currentTime = it->data.arrivalTime;
      }
    }
  }
  Scheduler::diplayStats(completedProcesses);
  return completedProcesses;
}

ProcessList Scheduler::roundRobin(ProcessList &masterList, int quantom) {
  ProcessQueue readyQueue;
  int currentTime = 0;
  int completed = 0;
  Node *it = masterList.getHead();
  int total = masterList.getSize();
  ProcessList completedProcesses;
  timeline.clear();

  while (completed < total) {
    // Load processes that have arrived by now
    while (it != nullptr && it->data.arrivalTime <= currentTime) {
      readyQueue.enqueue(it->data);
      it = it->next;
    }

    if (!readyQueue.isEmpty()) {
      Process p = readyQueue.dequeue();
      int timeToRun = (p.remainingTime < quantom) ? p.remainingTime : quantom;

      // Log slice
      Process slice = p;
      slice.arrivalTime = currentTime; // Start Time
      slice.burstTime = timeToRun;     // Duration
      timeline.push_back(slice);

      p.remainingTime -= timeToRun;
      currentTime += timeToRun;

      // Check for new arrivals DURING the time slice
      while (it != nullptr && it->data.arrivalTime <= currentTime) {
        readyQueue.enqueue(it->data);
        it = it->next;
      }

      if (p.remainingTime > 0) {
        readyQueue.enqueue(p);
      } else {
        p.completionTime = currentTime;
        p.waitingTime = p.completionTime - p.arrivalTime - p.burstTime;
        p.turnaroundTime = p.waitingTime + p.burstTime;
        completed++;
        completedProcesses.addProcess(p);
      }
    } else {
      if (it != nullptr) {
        currentTime = it->data.arrivalTime;
      }
    }
  }
  Scheduler::diplayStats(completedProcesses);
  return completedProcesses;
}
