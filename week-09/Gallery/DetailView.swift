//
//  DetailView.swift
//  Gallery
//
//  Created by Jonathan Parra on 2/4/24.
//

import SwiftUI

struct DetailView: View {
    let photo: PexelsPhoto

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    ZStack {
                        Color.black

                        AsyncImage(url: URL(string: photo.src.large2x ?? photo.src.original)) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.height * 0.5)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity)
                    }

                    Text(photo.alt)
                        .padding(.horizontal, 16)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle(photo.photographer)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DetailView(photo: PexelsPhoto.example)
    }
}
