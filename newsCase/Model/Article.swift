//
//  Article.swift
//  newsCase
//
//  Created by R. Metehan GÖKTAŞ on 14.05.2024.
//

import Foundation

struct Article: Codable, Identifiable {
    var id: UUID?
    let source: Source
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
}
