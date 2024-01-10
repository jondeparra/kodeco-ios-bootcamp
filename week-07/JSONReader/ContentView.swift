//
//  ContentView.swift
//  JSONReader
//
//  Created by Jonathan Parra on 1/8/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store = APIStore()
    @State private var errorMessage: String?
    @State private var showingSheet = false

    var body: some View {
        VStack {
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                NavigationStack {
                    List {
                        ForEach(store.apis) { api in
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
        }
        .onAppear {
            loadAPIList()
        }
    }

    private func loadAPIList() {
        do {
            try store.loadData()
        } catch DataLoadingError.fileNotFound {
            errorMessage = "Error: apilist.json file not found."
        } catch {
            errorMessage = "An unexpected error occurred."
        }
    }
}

#Preview {
    ContentView(store: APIStore())
}
