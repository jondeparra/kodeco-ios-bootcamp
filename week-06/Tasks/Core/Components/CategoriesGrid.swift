//
//  CategoriesGrid.swift
//  Tasks
//
//  Created by Jonathan Parra on 1/1/24.
//

import SwiftUI

struct CategoriesGrid: View {
    @ObservedObject var store: TaskStore
    @Binding var selectedCategory: Category?
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(Category.allCases) { category in
                VStack(spacing: 4) {
                    Text(category.rawValue.capitalized)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Text("\(countTasks(of: category))")
                        .font(.title)
                }
                .frame(height: 128)
                .frame(maxWidth: .infinity)
                .background(category == selectedCategory ? .accent.opacity(0.15) : .gray.opacity(0.15))
                .cornerRadius(16)
                .onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.prepare()
                    generator.impactOccurred()

                    withAnimation {
                        if selectedCategory == category {
                            selectedCategory = nil
                        } else {
                            selectedCategory = category
                        }
                    }
                }
            }
        }
        .listRowSeparator(.hidden)
    }

    func countTasks(of category: Category) -> Int {
        store.tasks.filter { $0.category == category }.count
    }
}

#Preview {
    CategoriesGrid(store: TaskStore(), selectedCategory: .constant(nil))
}
