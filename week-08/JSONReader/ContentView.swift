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
    @State private var showAlert = false
    @State private var isLoading = false

    var body: some View {
        TabView {
            NavigationStack {
                if isLoading {
                    ProgressView("Loading APIs...")
                        .navigationTitle("APIs")
                } else {
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
            }
            .tabItem {
                Label("APIs", systemImage: "network")
            }
            .onAppear {
                Task {
                    await loadAPIList()
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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage!),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private func loadAPIList() async {
        isLoading = true
        do {
            try await apiStore.loadData()
        } catch DataLoadingError.fileNotFound {
            errorMessage = "Error: apilist.json file not found."
            showAlert = true
        } catch {
            errorMessage = "An unexpected error occurred."
            showAlert = true
        }
        isLoading = false
    }
}

enum DataLoadingError: Error {
    case fileNotFound
    case invalidURL
    case networkError
}

#Preview {
    ContentView(apiStore: APIStore())
}
