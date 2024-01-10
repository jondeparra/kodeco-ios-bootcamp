//
//  TasksView.swift
//  Tasks
//
//  Created by Jonathan Parra on 12/31/23.
//

import SwiftUI

struct TasksView: View {
    @ObservedObject var store: TaskStore
    @State private var showingSheet = false
    @State private var searchText = ""
    @Binding var selectedCategory: Category?
    var taskStatus: Task.Status

    var filteredTasks: [Task] {
        store.tasks.filter { task in
            switch taskStatus {
            case .all:
                if let selectedCategory = selectedCategory {
                        return task.category == selectedCategory && (searchText.isEmpty || task.title.localizedCaseInsensitiveContains(searchText))
                    } else {
                        return searchText.isEmpty || task.title.localizedCaseInsensitiveContains(searchText)
                    }
            case .completed:
                return task.isCompleted && (searchText.isEmpty || task.title.localizedCaseInsensitiveContains(searchText))
            case .incomplete:
                return !task.isCompleted && (searchText.isEmpty || task.title.localizedCaseInsensitiveContains(searchText))
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                if taskStatus == .all {
                    CategoriesGrid(store: store, selectedCategory: $selectedCategory)
                }
                ForEach(filteredTasks) { task in
                    ZStack {
                        NavigationLink(destination: TaskDetailView(store: store, task: task)) { }
                            .opacity(0)
                        TaskRow(task: task) {
                            withAnimation {
                                store.toggleComplete(task)
                            }
                        }
                    }
                }
                .onDelete(perform: store.removeTask)
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .searchable(text: $searchText)
            .navigationTitle(
                taskStatus == .completed ? "Completed" :
                    taskStatus == .incomplete ? "Incomplete" : "All Tasks"
            )
            .sheet(isPresented: $showingSheet) {
                AddTaskView(store: store)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    TasksView(store: TaskStore(), selectedCategory: .constant(nil), taskStatus: .all)
}
