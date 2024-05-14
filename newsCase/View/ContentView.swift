//
//  ContentView.swift
//  newsCase
//
//  Created by R. Metehan GÖKTAŞ on 14.05.2024.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var searchResults: [Article] = []
    @State public var favoriteArticles: [Article] = []
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    SearchBar(text: $searchText, onSearch: { searchText in
                    search()
                    })
                    List(searchResults) { article in
                        NavigationLink(destination: ArticleDetailView(article: article, isFavorite: isArticleFavorite(article), addToFavorites: addArticleToFavorites, removeFromFavorites: removeFromFavorites)) {
                            ArticleRow(article: article)
                        }
                    }
                }
                .navigationTitle("News")
            }
            .tabItem {
                Label("News", systemImage: "newspaper")
            }
            
            NavigationView {
                List(favoriteArticles) { article in
                    NavigationLink(destination: ArticleDetailView(article: article, isFavorite: isArticleFavorite(article), addToFavorites: addArticleToFavorites, removeFromFavorites: removeFromFavorites)) {
                        ArticleRow(article: article)
                    }
                }
                .navigationTitle("Favorites")
            }
            .tabItem {
                Label("Favorites", systemImage: "star.fill")
            }
        }
        .onAppear {

            search()
        }
    }
    
    
    func search() {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=\(searchText)&apiKey=b2682cab450f42b29520fd835c5ae4e1") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ArticleResponse.self, from: data)
                DispatchQueue.main.async {
                    self.searchResults = result.articles
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    
    func addArticleToFavorites(_ article: Article) {
        if !isArticleFavorite(article) {
            favoriteArticles.append(article)
        }
    }
    
    
    func isArticleFavorite(_ article: Article) -> Bool {
        return favoriteArticles.contains(where: { $0.id == article.id })
    }
    
    
    func removeFromFavorites(_ article: Article) {
        if let index = favoriteArticles.firstIndex(where: { $0.id == article.id }) {
            favoriteArticles.remove(at: index)
        }
    }
}



