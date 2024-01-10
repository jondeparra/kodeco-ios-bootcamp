//
//  TaskStore.swift
//  Tasks
//
//  Created by Jonathan Parra on 12/23/23.
//

import Foundation

class TaskStore: ObservableObject {
    @Published var tasks: [Task]

    init() {
        tasks = [
            Task(title: "Study Swift", notes: "Study for 1-2 hours in the morning", isCompleted: false, category: .personal),
            Task(title: "Study Design", notes: "Study for at least 30 minutes", isCompleted: false, category: .personal),
            Task(title: "Do laundry", notes: "Make sure clothes are fresh", isCompleted: true, category: .chores),
            Task(title: "Vacuum room", notes: "Should only be 5 min of work", isCompleted: true, category: .chores),
            Task(title: "Take a walk", notes: "Easy way to stay healthy", isCompleted: false, category: .personal),
            Task(title: "Finish 3 paywalls", notes: "Should take 2 hours to finish each", isCompleted: false, category: .business)
        ]
    }

    func addTask(_ task: Task) {
        tasks.append(task)
    }

    func removeTask(at offset: IndexSet) {
        tasks.remove(atOffsets: offset)
    }

    func toggleComplete(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}
