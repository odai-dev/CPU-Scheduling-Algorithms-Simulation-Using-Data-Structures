# CPU Scheduling Algorithms Simulation Using Data Structures

A comprehensive CPU scheduling simulator implementing six classical scheduling algorithms with custom data structures. Features both command-line and interactive GUI interfaces with real-time Gantt chart visualization.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📋 Overview

This project demonstrates the implementation and comparative analysis of CPU scheduling algorithms used in operating systems. All data structures (Queue, Priority Queue, Linked List, Dynamic Array) are implemented from scratch to showcase fundamental data structure concepts.

## ✨ Features

### Implemented Algorithms
- **First Come First Serve (FCFS)** - Non-preemptive
- **Shortest Job First (SJF)** - Non-preemptive
- **Shortest Remaining Time First (SRTF)** - Preemptive SJF
- **Priority Scheduling** - Both preemptive and non-preemptive
- **Round Robin (RR)** - Configurable time quantum

### Custom Data Structures
- **ProcessQueue** - FIFO queue with O(1) operations
- **PriorityQueue** - Binary heap with O(log n) operations
- **ProcessList** - Sorted linked list for process management
- **DynamicArray** - Resizable array with amortized O(1) insertion

### Interactive GUI
- Built with **Dear ImGui**, **GLFW**, and **OpenGL**
- Real-time animated Gantt chart visualization
- Interactive process input and management
- Performance metrics display
- Algorithm comparison tools

### Performance Analysis
- Average Waiting Time calculation
- Average Turnaround Time calculation
- Completion time tracking
- Visual performance comparison

## 🖼️ Screenshots

### GUI Interface
The interactive GUI provides:
- Process input panel with manual and automatic data entry
- Six algorithm selection buttons
- Animated Gantt chart with timeline
- Real-time statistics and results table

### Performance Comparison
Comparative analysis showing SRTF achieves optimal average waiting time (2.6 time units) while Round Robin provides superior fairness.

## 🚀 Getting Started

### Prerequisites

**Required:**
- g++ compiler with C++17 support
- GLFW3 development libraries
- OpenGL development libraries

**Optional (for report compilation):**
- Typst (for generating PDF documentation)

### Installation

#### Ubuntu/Debian
```bash
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install libglfw3-dev
sudo apt-get install libgl1-mesa-dev
```

#### macOS
```bash
brew install glfw
```

## 🔨 Building

### Command-Line Application

```bash
# Navigate to project directory
cd CPU-Scheduling-Algorithms-Simulation-Using-Data-Structures

# Compile the console application
g++ -std=c++17 -o scheduler_cli \
    Process.cpp \
    DataStructures.cpp \
    Scheduler.cpp \
    main.cpp

# Run the program
./scheduler_cli
```

### GUI Application

```bash
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

## 📖 Usage

### GUI Application

1. **Add Processes:**
   - Manually enter Arrival Time, Burst Time, and Priority
   - Or click "Fill Dummy Data" for quick testing

2. **Select Algorithm:**
   - Click any of the six algorithm buttons
   - Adjust time quantum for Round Robin

3. **Visualize:**
   - Watch the animated Gantt chart
   - Use Pause/Resume and speed controls
   - Review statistics and results table

4. **Compare:**
   - Run multiple algorithms on the same dataset
   - Compare waiting times and turnaround times

### Command-Line Application

Follow the on-screen prompts to:
- Enter number of processes
- Input process details (ID, Arrival, Burst, Priority)
- Select scheduling algorithm
- View results table and statistics

## 📁 Project Structure

```
CPU-Scheduling-Algorithms-Simulation-Using-Data-Structures/
│
├── Process.h/cpp              # Process structure
├── DataStructures.h/cpp       # Custom data structures
├── Scheduler.h/cpp            # Scheduling algorithms
├── main.cpp                   # CLI application
│
├── gui/                       # GUI application
│   ├── gui_main.cpp           # GUI entry point
│   └── imgui*.cpp/h           # Dear ImGui library
│
├── images/                    # Report visualizations
│   ├── gantt_fcfs.jpg
│   ├── gantt_round_robin.jpg
│   ├── gantt_sjf_preemptive.jpg
│   ├── heap_visualization.jpg
│   ├── performance_comparison.jpg
│   └── process_state_diagram.jpg
│
├── report.typ                 # Project documentation (Typst)
├── report.pdf                 # Compiled report
└── README.md                  # This file
```

## 📊 Algorithm Performance

Based on test data with 5 processes:

| Algorithm | Avg Waiting Time | Avg Turnaround Time |
|-----------|------------------|---------------------|
| **SRTF** | **2.6** ⭐ | **6.2** ⭐ |
| SJF (Non-Preemptive) | 3.2 | 6.8 |
| FCFS | 3.8 | 7.4 |
| Priority (Non-Preemptive) | 4.0 | 7.6 |
| Priority (Preemptive) | 4.8 | 8.4 |
| Round Robin (Q=2) | 6.0 | 9.6 |

**Key Insights:**
- SRTF achieves optimal average waiting time
- Round Robin provides best fairness and response time
- FCFS is simplest but suffers from convoy effect
- Priority scheduling enables real-time system guarantees

## 🎓 Educational Value

This project serves as an educational tool for understanding:
- CPU scheduling concepts and trade-offs
- Data structure design and implementation
- Algorithm analysis and complexity
- GUI programming with immediate-mode frameworks
- Performance measurement and optimization

## 📄 Documentation

A comprehensive 45-page report is included (`report.pdf`) covering:
- Executive summary and project overview
- Detailed methodology and design decisions
- Complete data structure implementations
- All six algorithm variants with pseudocode
- Execution results and performance analysis
- GUI implementation details
- Compilation instructions and appendices

## 🙏 Acknowledgments

**Course Instructors:**
- Dr. Belal Murshed (Theory Instructor)
- T. Mohammed Al-Sayani (Lab Instructor)

**Development Tools:**
- [Dear ImGui](https://github.com/ocornut/imgui) by Omar Cornut
- [GLFW](https://www.glfw.org/) library
- [Typst](https://typst.app/) typesetting system

**AI Assistance:**
- Gemini CLI for GUI implementation guidance

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Odai Masnoor Gubran**
- Student ID: 202410100532
- Institution: Ar-Rasheed Smart University
- GitHub: [@odai-dev](https://github.com/odai-dev)

## 🔗 Links

- [GitHub Repository](https://github.com/odai-dev/CPU-Scheduling-Algorithms-Simulation-Using-Data-Structures)
- [Full Project Report (PDF)](report.pdf)

---

**Note:** This project was developed as part of the Data Structures and Algorithms course at Ar-Rasheed Smart University, February 2026.
