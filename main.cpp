#include "Scheduler.h"
#include <iostream>
using namespace std;

void loadDummyData(ProcessList &list) {
  Process processes[] = {// ID, Arrival, Burst, Priority
                         {1, 0, 5, 3},
                         {2, 1, 3, 2},
                         {3, 2, 4, 1},
                         {4, 3, 2, 5},
                         {5, 50, 4, 4}};

  for (int i = 0; i < 5; i++) {
    list.addProcess(processes[i]);
  }
  cout << "\n✓ Loaded 5 dummy processes successfully!" << endl;
}

void enterManualData(ProcessList &list) {
  int numProcesses;
  cout << "\nEnter number of processes: ";
  cin >> numProcesses;

  for (int i = 0; i < numProcesses; i++) {
    Process p;
    cout << "\n--- Process " << (i + 1) << " ---" << endl;

    p.id = i + 1;
    cout << "Arrival Time: ";
    cin >> p.arrivalTime;

    cout << "Burst Time: ";
    cin >> p.burstTime;

    cout << "Priority (lower number = higher priority): ";
    cin >> p.priority;

    p.remainingTime = p.burstTime;
    list.addProcess(p);
  }
  cout << "\n✓ Added " << numProcesses << " processes successfully!" << endl;
}

void displayProcessList(ProcessList &list) {
  cout << "\n=== Current Process List ===" << endl;
  cout << "ID\tArrival\tBurst\tPriority" << endl;
  cout << "-----------------------------------" << endl;

  Node *curr = list.getHead();
  while (curr != nullptr) {
    cout << "P" << curr->data.id << "\t" << curr->data.arrivalTime << "\t"
         << curr->data.burstTime << "\t" << curr->data.priority << endl;
    curr = curr->next;
  }
  cout << "===================================" << endl;
}

int main() {
  ProcessList list;
  bool dataLoaded = false;
  int choice;

  cout << "\n╔════════════════════════════════════════╗" << endl;
  cout << "║   CPU Scheduling Simulator (CLI)      ║" << endl;
  cout << "╚════════════════════════════════════════╝" << endl;

  do {
    cout << "\n--- Main Menu ---" << endl;

    if (!dataLoaded) {
      cout << "1. Load Dummy Process Data" << endl;
      cout << "2. Enter Processes Manually" << endl;
      cout << "3. Exit" << endl;
      cout << "Enter choice: ";
      cin >> choice;

      switch (choice) {
      case 1:
        list.clear();
        loadDummyData(list);
        displayProcessList(list);
        dataLoaded = true;
        break;
      case 2:
        list.clear();
        enterManualData(list);
        displayProcessList(list);
        dataLoaded = true;
        break;
      case 3:
        cout << "\nExiting... Goodbye!" << endl;
        return 0;
      default:
        cout << "\n✗ Invalid choice! Please try again." << endl;
      }
    } else {
      cout << "=== Scheduling Algorithms ===" << endl;
      cout << "1. Run FCFS (First Come First Serve)" << endl;
      cout << "2. Run SJF (Shortest Job First)" << endl;
      cout << "3. Run SRTF (Preemptive SJF)" << endl;
      cout << "4. Run Priority (Non-Preemptive)" << endl;
      cout << "5. Run Preemptive Priority" << endl;
      cout << "6. Run Round Robin" << endl;
      cout << "7. View Process List" << endl;
      cout << "8. Reset & Load New Data" << endl;
      cout << "9. Exit" << endl;
      cout << "Enter choice: ";
      cin >> choice;

      switch (choice) {
      case 1:
        cout << "\n=== Running FCFS Algorithm ===" << endl;
        Scheduler::runFCFS(list);
        break;
      case 2:
        cout << "\n=== Running SJF (Non-Preemptive) ===" << endl;
        Scheduler::runSJF(list, false);
        break;
      case 3:
        cout << "\n=== Running SRTF (Preemptive SJF) ===" << endl;
        Scheduler::runSJF(list, true);
        break;
      case 4:
        cout << "\n=== Running Priority (Non-Preemptive) ===" << endl;
        Scheduler::runPriority(list, false);
        break;
      case 5:
        cout << "\n=== Running Preemptive Priority ===" << endl;
        Scheduler::runPriority(list, true);
        break;
      case 6: {
        int quantum;
        cout << "\nEnter time quantum for Round Robin: ";
        cin >> quantum;
        cout << "\n=== Running Round Robin (Quantum=" << quantum
             << ") ===" << endl;
        Scheduler::roundRobin(list, quantum);
        break;
      }
      case 7:
        displayProcessList(list);
        break;
      case 8:
        dataLoaded = false;
        cout << "\n✓ Reset successful! You can now load new data." << endl;
        break;
      case 9:
        cout << "\nExiting... Goodbye!" << endl;
        return 0;
      default:
        cout << "\n✗ Invalid choice! Please try again." << endl;
      }
    }
  } while (true);

  return 0;
}
