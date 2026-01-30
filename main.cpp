#include "DataStructures.h"
#include "Scheduler.h"
#include <iostream>
using namespace std;


int main() {
    Process processes[5] = {
        // ID, Arrival, Burst, Priority, Remaining, Waiting, Turnaround, Completion
        {1, 0, 5, 2, 5, 0, 0, 0},
        {2, 1, 3, 1, 3, 0, 0, 0},
        {3, 2, 8, 3, 8, 0, 0, 0},
        {4, 3, 2, 4, 2, 0, 0, 0},
        {5, 4, 4, 2, 4, 0, 0, 0}
    };

    ProcessList list;

    for(int i = 0; i < 5; i++) {
        list.addProcess(processes[i]);
    }

    int choice;
    do {
        cout<<"\n--- CPU Scheduler ---"<<endl;
        cout<<"1. Run FCFS"<<endl;
        cout<<"2. Run SJF"<<endl;
        cout<<"3. Exit"<<endl;
        cout<<"Enter a choice: ";
        cin>>choice;

        switch (choice)
        {
        case 1 :
            // Scheduler::runFCFS(list);
            break;
        case 2:
            // Scheduler::runSJF(list);
            break;
        

       }
    } while (choice!= 3);
    
    return 0;
}