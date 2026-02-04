// -----------------------------------------------------------------------------
// OS Scheduler Visualizer GUI
// Implemented with the assistance of Gemini CLI
// -----------------------------------------------------------------------------

#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"
#include <stdio.h>
#include <GLFW/glfw3.h> 
#include "../Scheduler.h"

// --- PERSISTENT STATE (Outside Main) ---
static ProcessList masterList;
static ProcessList resultList; // Stores the results (for the table)
static int nextId = 1;
static int arr = 0, burst = 5, prio = 3;
static int quantum = 2;
static bool hasResults = false;

// --- ANIMATION STATE ---
static float animationTime = 0.0f;
static float animationSpeed = 20.0f; // Time units per second
static bool isPaused = false;
static float maxTime = 0.0f;

int main() {
    if (!glfwInit()) return 1;
    GLFWwindow* window = glfwCreateWindow(1280, 800, "OS Scheduler Visualizer", NULL, NULL);
    glfwMakeContextCurrent(window);
    glfwSwapInterval(1);

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO();
    io.FontGlobalScale = 1.5f; 
    ImGui_ImplGlfw_InitForOpenGL(window, true);
    ImGui_ImplOpenGL3_Init("#version 130");

    while (!glfwWindowShouldClose(window)) {
        glfwPollEvents();
        ImGui_ImplOpenGL3_NewFrame();
        ImGui_ImplGlfw_NewFrame();
        ImGui::NewFrame();

        ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(8, 8));
        ImGui::PushStyleVar(ImGuiStyleVar_ItemSpacing, ImVec2(10, 10));

        // --- WINDOW 1: INPUT ---
        ImGui::Begin("Process Controller", nullptr, ImGuiWindowFlags_AlwaysAutoResize);
        ImGui::SetWindowFontScale(1.1f);
        
        ImGui::Text("Add New Process:");
        ImGui::Columns(3, "InputColumns", false);
        ImGui::SetNextItemWidth(120);
        ImGui::InputInt("Arrival", &arr); ImGui::NextColumn();
        ImGui::SetNextItemWidth(120);
        ImGui::InputInt("Burst", &burst); ImGui::NextColumn();
        ImGui::SetNextItemWidth(120);
        ImGui::InputInt("Priority", &prio); ImGui::Columns(1);
        
        ImGui::Spacing();
        if (ImGui::Button("Add Process", ImVec2(180, 40))) {
            masterList.addProcess(Process{nextId++, arr, burst, prio}); 
            arr = 0; burst = 5; prio = 3;
        }
        ImGui::SameLine();
        if (ImGui::Button("Fill Dummy Data", ImVec2(180, 40))) {
            masterList.addProcess(Process{nextId++, 0, 5, 3});
            masterList.addProcess(Process{nextId++, 1, 3, 2});
            masterList.addProcess(Process{nextId++, 2, 4, 1});
            masterList.addProcess(Process{nextId++, 3, 2, 5});
            masterList.addProcess(Process{nextId++, 5, 4, 4});
        }
        ImGui::SameLine();
        if (ImGui::Button("Clear Input", ImVec2(180, 40))) {
            masterList.clear();
            resultList.clear();
            Scheduler::timeline.clear();
            nextId = 1;
            hasResults = false;
        }

        // Input Data Table
        ImGui::Spacing();
        ImGui::Separator();
        ImGui::Text("Current Processes:");
        if (ImGui::BeginTable("InputTable", 4, ImGuiTableFlags_Borders | ImGuiTableFlags_RowBg | ImGuiTableFlags_Resizable)) {
            ImGui::TableSetupColumn("ID", ImGuiTableColumnFlags_WidthFixed, 50.0f);
            ImGui::TableSetupColumn("Arrival", ImGuiTableColumnFlags_WidthStretch);
            ImGui::TableSetupColumn("Burst", ImGuiTableColumnFlags_WidthStretch);
            ImGui::TableSetupColumn("Priority", ImGuiTableColumnFlags_WidthStretch);
            ImGui::TableHeadersRow();

            Node* curr = masterList.getHead();
            while (curr) {
                ImGui::TableNextRow(ImGuiTableRowFlags_None, 30.0f);
                ImGui::TableSetColumnIndex(0); ImGui::Text("P%d", curr->data.id);
                ImGui::TableSetColumnIndex(1); ImGui::Text("%d", curr->data.arrivalTime);
                ImGui::TableSetColumnIndex(2); ImGui::Text("%d", curr->data.burstTime);
                ImGui::TableSetColumnIndex(3); ImGui::Text("%d", curr->data.priority);
                curr = curr->next;
            }
            ImGui::EndTable();
        }

        ImGui::Separator();
        ImGui::Text("Run Algorithm:");
        
        // Helper to reset animation on run
        auto ResetAnimation = []() {
            animationTime = 0.0f;
            isPaused = false;
            maxTime = 0;
            Node* t = Scheduler::timeline.getHead();
            while(t) {
                if (t->data.arrivalTime + t->data.burstTime > maxTime)
                    maxTime = t->data.arrivalTime + t->data.burstTime;
                t = t->next;
            }
        };

        // Row 1
        if (ImGui::Button("FCFS", ImVec2(180, 45))) {
            resultList.clear(); resultList = Scheduler::runFCFS(masterList);
            ResetAnimation(); hasResults = true;
        }
        ImGui::SameLine();
        if (ImGui::Button("Round Robin", ImVec2(180, 45))) {
            resultList.clear(); resultList = Scheduler::roundRobin(masterList, quantum);
            ResetAnimation(); hasResults = true;
        }
        ImGui::SameLine();
        ImGui::SetNextItemWidth(100);
        ImGui::InputInt("Quantum", &quantum);
        if (quantum < 1) quantum = 1;

        // Row 2
        if (ImGui::Button("SJF (Non-Preem)", ImVec2(240, 45))) {
            resultList.clear(); resultList = Scheduler::runSJF(masterList, false);
            ResetAnimation(); hasResults = true;
        }
        ImGui::SameLine();
        if (ImGui::Button("SRTF (Preem SJF)", ImVec2(240, 45))) {
            resultList.clear(); resultList = Scheduler::runSJF(masterList, true);
            ResetAnimation(); hasResults = true;
        }

        // Row 3
        if (ImGui::Button("Priority (Non-Preem)", ImVec2(240, 45))) {
            resultList.clear(); resultList = Scheduler::runPriority(masterList, false);
            ResetAnimation(); hasResults = true;
        }
        ImGui::SameLine();
        if (ImGui::Button("Preemptive Priority", ImVec2(240, 45))) {
            resultList.clear(); resultList = Scheduler::runPriority(masterList, true);
            ResetAnimation(); hasResults = true;
        }
        
        ImGui::End();

        // --- WINDOW 2: GANTT CHART ---
        if (hasResults) {
            ImGui::Begin("Gantt Chart & Stats", nullptr, ImGuiWindowFlags_HorizontalScrollbar);
            ImGui::SetWindowFontScale(1.1f);
            
            // Animation Controls
            if (ImGui::Button(isPaused ? "Resume" : "Pause", ImVec2(120, 40))) {
                isPaused = !isPaused;
            }
            ImGui::SameLine();
            if (ImGui::Button("Restart", ImVec2(120, 40))) {
                animationTime = 0.0f;
                isPaused = false;
            }
            ImGui::SameLine();
            ImGui::SetNextItemWidth(300);
            ImGui::SliderFloat("Speed", &animationSpeed, 1.0f, 100.0f, "%.1f units/s");
            
            if (!isPaused && animationTime < maxTime) {
                animationTime += io.DeltaTime * (animationSpeed / 5.0f); 
                if (animationTime > maxTime) animationTime = maxTime;
            }

                        // Draw Gantt Chart from Timeline

                        ImDrawList* draw_list = ImGui::GetWindowDrawList();

                        ImVec2 p = ImGui::GetCursorScreenPos();

                        

                        // Snap starting position to pixel grid

                        p.x = (float)((int)p.x);

                        p.y = (float)((int)p.y);

                        

                        float chartHeight = 80.0f;

                        float scaleX = 30.0f; 

                        

                        Node* curr = Scheduler::timeline.getHead();

                        while (curr) {

                            Process& slice = curr->data;

                            // Snap calculations to pixels

                            float startX = (float)((int)(slice.arrivalTime * scaleX));

                            float width = (float)((int)(slice.burstTime * scaleX));

                            float endX = startX + width;

                            float visibleEndX = (float)((int)(animationTime * scaleX));

            

                            if (visibleEndX > startX) {

                                float drawWidth = width;

                                if (visibleEndX < endX) drawWidth = visibleEndX - startX;

                                

                                ImU32 color = IM_COL32(60, 140, 230, 255);

                                if (slice.id % 2 == 0) color = IM_COL32(40, 120, 210, 255);

                                if (slice.id % 3 == 0) color = IM_COL32(80, 160, 250, 255);

            

                                draw_list->AddRectFilled(ImVec2(p.x + startX, p.y + 40), 

                                                        ImVec2(p.x + startX + drawWidth, p.y + 40 + chartHeight), 

                                                        color);

                                                        

                                draw_list->AddRect(ImVec2(p.x + startX, p.y + 40), 

                                                   ImVec2(p.x + startX + drawWidth, p.y + 40 + chartHeight), 

                                                   IM_COL32(255, 255, 255, 255), 0, 0, 2.0f);

            

                                if (drawWidth > 15.0f) {

                                    char buf[16]; sprintf(buf, "P%d", slice.id);

                                    draw_list->AddText(ImGui::GetFont(), ImGui::GetFontSize(), 

                                                       ImVec2(p.x + startX + 5, p.y + 40 + (chartHeight/2) - 10), 

                                                       IM_COL32(255,255,255,255), buf);

                                }

                            }

                            curr = curr->next;

                        }

            ImGui::Dummy(ImVec2(maxTime * scaleX, chartHeight + 60)); 
            
            // Calculate Averages
            float totalWait = 0.0f;
            float totalTurnaround = 0.0f;
            int count = 0;
            Node* statNode = resultList.getHead();
            while(statNode) {
                totalWait += statNode->data.waitingTime;
                totalTurnaround += statNode->data.turnaroundTime;
                count++;
                statNode = statNode->next;
            }
            float avgWait = (count > 0) ? totalWait / count : 0.0f;
            float avgTurn = (count > 0) ? totalTurnaround / count : 0.0f;

            ImGui::Text("Simulation Statistics (Final Results):");
            ImGui::TextColored(ImVec4(0.6f, 0.8f, 1.0f, 1.0f), "Avg Waiting Time: %.2f  |  Avg Turnaround Time: %.2f", avgWait, avgTurn);
            
            if (ImGui::BeginTable("Results", 4, ImGuiTableFlags_Borders | ImGuiTableFlags_RowBg | ImGuiTableFlags_Resizable)) {
                ImGui::TableSetupColumn("ID", ImGuiTableColumnFlags_WidthFixed, 60.0f);
                ImGui::TableSetupColumn("Finish", ImGuiTableColumnFlags_WidthStretch);
                ImGui::TableSetupColumn("Waiting", ImGuiTableColumnFlags_WidthStretch);
                ImGui::TableSetupColumn("Turnaround", ImGuiTableColumnFlags_WidthStretch);
                ImGui::TableHeadersRow();

                curr = resultList.getHead();
                while (curr) {
                    ImGui::TableNextRow(ImGuiTableRowFlags_None, 35.0f);
                    ImGui::TableSetColumnIndex(0); ImGui::Text("P%d", curr->data.id);
                    ImGui::TableSetColumnIndex(1); ImGui::Text("%d", curr->data.completionTime);
                    ImGui::TableSetColumnIndex(2); ImGui::Text("%d", curr->data.waitingTime);
                    ImGui::TableSetColumnIndex(3); ImGui::Text("%d", curr->data.turnaroundTime);
                    curr = curr->next;
                }
                ImGui::EndTable();
            }
            ImGui::End();
        }

        ImGui::PopStyleVar(2); 

        ImGui::Render();
        int display_w, display_h;
        glfwGetFramebufferSize(window, &display_w, &display_h);
        glViewport(0, 0, display_w, display_h);
        glClearColor(0.1f, 0.1f, 0.1f, 1.0f); 
        glClear(GL_COLOR_BUFFER_BIT);
        ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
        glfwSwapBuffers(window);
    }
    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplGlfw_Shutdown();
    ImGui::DestroyContext();

    glfwDestroyWindow(window);
    glfwTerminate();
    return 0;
}