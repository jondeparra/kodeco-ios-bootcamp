//
//  SearchView.swift
//  Gallery
//
//  Created by Jonathan Parra on 1/31/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = PexelsPhotosViewModel()
    @State private var searchTerm = ""

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    VStack(spacing: 16.0) {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: geo.size.width * 0.33, maximum: geo.size.width * 0.5), spacing: 16), count: 2), spacing: 16) {
                            ForEach(viewModel.photos) { photo in
                                NavigationLink(destination: DetailView(photo: photo)) {
                                    AsyncImage(url: URL(string: photo.src.medium ?? photo.src.original)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 100)
                                            .clipped()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(minWidth: geo.size.width * 0.33, maxWidth: .infinity)
                                    .cornerRadius(8)
                                }
                            }
                        }

                        if !viewModel.photos.isEmpty {
                            VStack(spacing: 8) {
                                Button("Load more") {
                                    viewModel.searchPhotos(query: searchTerm)
                                }
                                .buttonStyle(.borderedProminent)

                                Spacer()

                                Button(role: .destructive, action: {
                                    viewModel.clearPhotos()
                                    searchTerm = ""
                                }, label: {
                                    Text("Clear Search")
                                })
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Pexels")
            .padding(.horizontal, 16)
            .onSubmit(of: .search) {
                if viewModel.photos.isEmpty {
                    viewModel.searchPhotos(query: searchTerm)
                }
            }
            .navigationTitle("Pexels Search")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if !viewModel.photos.isEmpty {
                        Button(role: .destructive, action: {
                            viewModel.clearPhotos()
                            searchTerm = ""
                        }, label: {
                            Text("Clear")
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
