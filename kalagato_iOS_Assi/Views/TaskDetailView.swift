//
//  TaskDetailView.swift
//  kalagato_iOS_Assi
//
//  Created by Ritik Karma on 11/03/25.
//

import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var viewModel: TaskViewModel
    var task: Task?

    @State private var title: String = ""
    @State private var details: String = ""
    @Environment(\.presentationMode) var presentationMode

    init(viewModel: TaskViewModel, task: Task?) {
        self.viewModel = viewModel
        self.task = task
        _title = State(initialValue: task?.title ?? "")
        _details = State(initialValue: task?.details ?? "")
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Title")) {
                    TextField("Enter task title", text: $title)
                }

                Section(header: Text("Task Details")) {
                    TextField("Enter task details", text: $details)
                }
            }
            .navigationTitle(task == nil ? "New Task" : "Edit Task")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    if let task = task {
                        viewModel.editTask(task: task, newTitle: title, newDetails: details)
                    } else {
                        viewModel.addTask(title: title, details: details)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

//#Preview {
//    TaskDetailView()
//}
