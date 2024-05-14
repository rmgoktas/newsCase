//
//  newsCaseTests.swift
//  newsCaseTests
//
//  Created by R. Metehan GÖKTAŞ on 14.05.2024.
//

import XCTest
@testable import newsCase

class ContentViewTests: XCTestCase {
    
    func testRemoveFromFavorites() {
        var contentView = ContentView()
        let article = Article(id: UUID(), source: Source(id: "1", name: "Test Source"), title: "Test Article", description: "Test Description", url: "https://test.com", urlToImage: "https://test.com/image.jpg", publishedAt: "2024-05-14")
        
        // favoriler bos mu???
        XCTAssertTrue(contentView.favoriteArticles.isEmpty)
        
        // favorilere makale ekle
        contentView.addArticleToFavorites(article)
        
        // favorilere eklenmis mi??
        XCTAssertFalse(contentView.favoriteArticles.isEmpty)
        XCTAssertTrue(contentView.isArticleFavorite(article))
        
        // favoilerden makaleyi kaldir
        contentView.removeFromFavorites(article)
        
        // favoriler bos mu??
        XCTAssertTrue(contentView.favoriteArticles.isEmpty)
        XCTAssertFalse(contentView.isArticleFavorite(article))
    }
}
