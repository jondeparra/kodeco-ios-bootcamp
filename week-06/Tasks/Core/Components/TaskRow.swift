//
//  TaskRow.swift
//  Tasks
//
//  Created by Jonathan Parra on 12/23/23.
//

import SwiftUI

struct TaskRow: View {
    let task: Task
    var onImageTap: () -> Void

    var body: some View {
        HStack {
            if task.isCompleted {
                Text("\(task.title)")
                    .strikethrough()
                    .foregroundStyle(.secondary)
            } else {
                Text("\(task.title)")
            }
            Spacer()
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .resizable()
                .padding(12)
                .frame(width: 44, height: 44)
                .foregroundStyle(task.isCompleted ? .green : .secondary)
                .onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.prepare()
                    generator.impactOccurred()
                    onImageTap()
                }
        }
    }
}

#Preview {
    Form {
        TaskRow(task: Task.example) { }
    }
}
