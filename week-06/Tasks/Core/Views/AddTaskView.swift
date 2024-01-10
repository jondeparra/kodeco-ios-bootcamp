//
//  AddTaskView.swift
//  Tasks
//
//  Created by Jonathan Parra on 12/24/23.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: TaskStore
    @State private var title = ""
    @State private var notes = ""
    @State private var category: Category = .uncategorized

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("", text: $title)
                } header: {
                    Text("Title")
                }

                Section {
                    TextEditor(text: $notes)
                        .frame(minHeight: 100)
                } header: {
                    Text("Notes")
                }

                Picker("Category", selection: $category) {
                    ForEach(Category.allCases) { category in
                        Text(category.rawValue.capitalized)
                    }
                }
            }
            .navigationTitle("Add task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        store.addTask(Task(id: UUID(), title: title, notes: notes, isCompleted: false, category: category))
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddTaskView(store: TaskStore())
}
