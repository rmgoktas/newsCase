//
//  ArticleDetailView.swift
//  newsCase
//
//  Created by R. Metehan GÖKTAŞ on 14.05.2024.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: Article
    let isFavorite: Bool
    let addToFavorites: (Article) -> Void
    let removeFromFavorites: (Article) -> Void
    
    @State private var isShowingSource = false
    @State private var isShowingShareSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                RemoteImage(url: article.urlToImage ?? "")
                    .frame(height: 200)
                    .clipped()
                
                Text(article.title)
                    .font(.title)
                    .padding()
                
                if let description = article.description {
                    Text(description)
                        .padding()
                }
                
                Text("Published on: \(article.publishedAt)")
                    .foregroundColor(.gray)
                    .padding()
                
                HStack {
                    // PAYLAS
                    Button(action: {
                        isShowingShareSheet = true
                    }) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    .padding()
                    .sheet(isPresented: $isShowingShareSheet, content: {
                        ShareSheet(activityItems: [article.url])
                    })
                    
                    // FAVORI EKLE/CIKAR
                    if !isFavorite {
                        Button(action: {
                            addToFavorites(article)
                        }) {
                            Label("Add to Favorites", systemImage: "heart")
                        }
                        .padding()
                    } else {
                        Button(action: {
                            removeFromFavorites(article)
                        }) {
                            Label("Remove from Favorites", systemImage: "heart.fill")
                        }
                        .padding()
                    }
                }
                
                Button(action: {
                    isShowingSource = true
                }) {
                    Text("Go to Source")
                        .padding()
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $isShowingSource) {
                    if let url = URL(string: article.url) {
                        WebView(url: url)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Detail")
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}

