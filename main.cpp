#include <iostream>
#include "Scheduler.h"
using namespace std;


int main() {
Process processes[] = {
    // ID, Arrival, Burst, Priority
    {1, 0,  5, 3},
    {2, 1,  3, 2},
    {3, 2,  4, 1},
    {4, 3,  2, 5},
    {5, 50, 4, 4}
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
        cout<<"3. Run Preemptive SJF (SRTF)"<<endl;
        cout<<"4. Run Priority"<<endl;
        cout<<"5. Run Preemptive Priority"<<endl;
        cout<<"6. Run Round Robin"<<endl;
        cout<<"7. Exit"<<endl;
        cout<<"Enter a choice: ";
        cin>>choice;

        switch (choice)
        {
        case 1 :
            Scheduler::runFCFS(list);
            break;
        case 2:
            Scheduler::runSJF(list, false);
            break;
        case 3:
            Scheduler::runSJF(list, true);
            break;
        case 4:
            Scheduler::runPriority(list, false);
            break;
        case 5:
            Scheduler::runPriority(list, true);
            break;
        case 6:
            Scheduler::roundRobin(list,2);
            break;

       }
    } while (choice!= 7);
    
    return 0;
}

