//
//  TaskDetailView.swift
//  Tasks
//
//  Created by Jonathan Parra on 12/24/23.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: TaskStore
    @State var task: Task

    var body: some View {
        Form {
            Section {
                TextField("", text: $task.title)
            } header: {
                Text("Title")
            }
            
            Section {
                TextEditor(text: $task.notes)
                    .frame(minHeight: 100)
            } header: {
                Text("Notes")
            }

            Picker("Category", selection: $task.category) {
                ForEach(Category.allCases) { category in
                    Text(category.rawValue.capitalized)
                }
            }

            Toggle(isOn: $task.isCompleted) {
                Text("Completed")
            }
        }
        .navigationTitle("Edit task")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Update") {
                    if let index = store.tasks.firstIndex(where: { $0.id == task.id }) {
                        store.tasks[index] = task
                    }
                    dismiss()
                }
                .disabled(task.title.isEmpty)
            }
        }
    }
}

#Preview {
    NavigationView {
        TaskDetailView(store: TaskStore(), task: Task.example)
    }
}
