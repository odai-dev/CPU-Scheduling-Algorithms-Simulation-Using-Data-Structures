#include <iostream>
#include "Scheduler.h"
using namespace std;


int main() {
Process processes[] = {
    // ID, Arrival, Burst, Priority
    {1, 0,  5, 2},
    {2, 1,  3, 1},
    {3, 2,  8, 3},
    {4, 3,  2, 4},
    {5, 50, 4, 2}
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
            Scheduler::runFCFS(list);
            break;
        case 2:
            Scheduler::runSJF(list);
            break;
        

       }
    } while (choice!= 3);
    
    return 0;
}