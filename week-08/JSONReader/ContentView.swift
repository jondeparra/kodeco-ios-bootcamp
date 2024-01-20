//
//  ContentView.swift
//  JSONReader
//
//  Created by Jonathan Parra on 1/8/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var apiStore = APIStore()
    @StateObject var userStore = UserStore()
    @State private var errorMessage: String?

    var body: some View {
        TabView {
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.headline)
            } else {
                NavigationStack {
                    List {
                        ForEach(apiStore.apis) { api in
                            NavigationLink(api.name) {
                                APIDetails(api: api)
                                    .navigationTitle(api.name)
                                    .navigationBarTitleDisplayMode(.inline)
                            }
                        }
                    }
                    .navigationTitle("APIs")
                }
                .tabItem {
                    Label("APIs", systemImage: "network")
                }
                .onAppear {
                    loadAPIList()
                }
            }

            NavigationStack {
                UserDetails(user: userStore.users.first!)
                .navigationTitle("User Details")
            }
            .tabItem {
                Label("User", systemImage: "person")
            }
        }
    }

    private func loadAPIList() {
        do {
            try apiStore.loadData()
        } catch DataLoadingError.fileNotFound {
            errorMessage = "Error: apilist.json file not found."
        } catch {
            errorMessage = "An unexpected error occurred."
        }
    }
}

enum DataLoadingError: Error {
    case fileNotFound
}

#Preview {
    ContentView(apiStore: APIStore())
}
