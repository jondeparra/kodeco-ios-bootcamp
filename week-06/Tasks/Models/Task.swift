//
//  Task.swift
//  Tasks
//
//  Created by Jonathan Parra on 12/23/23.
//

import Foundation

struct Task: Identifiable, Hashable{
    var id = UUID()
    var title: String
    var notes: String
    var isCompleted: Bool
    var category = Category.uncategorized

    static let example = Task(title: "Run for 1 mile", notes: "Daily running for heart health", isCompleted: false, category: .personal)

    enum Status {
        case all
        case completed
        case incomplete
    }
}

enum Category: String, CaseIterable, Identifiable {
    case personal
    case business
    case chores
    case uncategorized
    var id: Self { self }
}
