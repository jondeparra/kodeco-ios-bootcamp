//
//  MainView.swift
//  Tasks
//
//  Created by Jonathan Parra on 12/20/23.
//

import SwiftUI

struct MainView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var store = TaskStore()
    @State private var selectedTab: Tab = .main
    @State private var selectedCategory: Category? = nil

    enum Tab {
        case main
        case incomplete
        case completed
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            TasksView(store: store, selectedCategory: $selectedCategory, taskStatus: .all)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Tasks")
                }
                .tag(Tab.main)

            TasksView(store: store, selectedCategory: $selectedCategory, taskStatus: .incomplete)
                .tabItem {
                    Image(systemName: "circle.dotted")
                    Text("Incomplete")
                }
                .tag(Tab.incomplete)

            TasksView(store: store, selectedCategory: $selectedCategory, taskStatus: .completed)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Completed")
                }
                .tag(Tab.completed)
        }
        .onChange(of: selectedTab) {
            selectedCategory = nil
        }
    }
}

#Preview {
    MainView(store: TaskStore())
}
