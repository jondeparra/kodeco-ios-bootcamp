//
//  APIDetails.swift
//  JSONReader
//
//  Created by Jonathan Parra on 1/9/24.
//

import SwiftUI
import WebKit

struct APIDetails: View {
    var api: API = .example

    var body: some View {
        List {
            Section {
                Text(api.name)
            } header: {
                Text("API Name")
            }

            Section {
                Text(api.description)
            } header: {
                Text("Description")
            }


            Section {
                HStack {
                    Text("Auth Type")
                    Spacer()
                    Text(api.auth == "" ? "N/a" : api.auth)
                        .foregroundStyle(.secondary)
                }

                HStack {
                    Text("HTTPS")
                    Spacer()
                    Text(api.https ? "Yes" : "No")
                        .foregroundStyle(.secondary)
                }

                HStack {
                    Text("Cors")
                    Spacer()
                    Text(api.cors.capitalized)
                        .foregroundStyle(.secondary)
                }

                NavigationLink("Link") {
                    WebView(url: api.link)
                        .navigationBarTitleDisplayMode(.inline)
                }
                .foregroundStyle(Color.accentColor)

                HStack {
                    Text("Category")
                    Spacer()
                    Text(api.category)
                        .foregroundStyle(.secondary)
                }
            } header: {
                Text("Details")
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    var url:String

    func makeUIView(context: Context) -> some UIView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        let webview = WKWebView()
        webview.load(URLRequest(url: url))
        return webview
    }

    func updateUIView(_ uiView: UIViewType, context: Context) { }
}

#Preview {
    APIDetails(api: API.example)
}
