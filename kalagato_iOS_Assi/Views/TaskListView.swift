//
//  TaskListView.swift
//  kalagato_iOS_Assi
//
//  Created by Ritik Karma on 11/03/25.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    @State private var newTaskDetails = ""
    @State private var isAddingTask = false
    @State private var selectedTask: Task?

    var body: some View {
        NavigationView {
            VStack {
                Button("Add New Task") {
                    isAddingTask = true
                    selectedTask = nil
                }
                .padding()
                .sheet(isPresented: $isAddingTask) {
                    TaskDetailView(viewModel: viewModel, task: selectedTask)
                }

                List {
                    ForEach(viewModel.tasks) { task in
                        NavigationLink(destination: TaskDetailView(viewModel: viewModel, task: task)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Button(action: {
                                        viewModel.toggleCompletion(for: task)
                                    }) {
                                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(task.isCompleted ? .green : .gray)
                                    }
                                    .buttonStyle(PlainButtonStyle())

                                    Text(task.title)
                                        .strikethrough(task.isCompleted)
                                        .font(.headline)
                                }
                                Text(task.details)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
            }
            .navigationTitle("To-Do List")
        }
    }
}

#Preview {
    TaskListView()
}
