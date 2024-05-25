//
//  TestHelpers.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

import Foundation
import UIKit
@testable import NewsApp

func anyNewsOutput() -> NewsOutput {
    return NewsOutput(status: "any-status", 
                      totalResults: 0,
                      articles: [
                        Article(source: SourceItem(id: "any-id", name: "any-name"),
                                author: "any-author",
                                title: "any-title",
                                description: "any-description",
                                url: "any-url",
                                urlToImage: "any-url",
                                publishedAt: "any-date",
                                content: "any-content")
                      ])
}

func anyNewsOutputWithEmptyList() -> NewsOutput {
    return NewsOutput(status: "any-status",
                      totalResults: 0,
                      articles: [])
}

func anyNewsDetails() -> NewsItem {
    return NewsItem(id: "any-id",
                    author: "any-author",
                    title: "any-title",
                    description: "any-description",
                    image: UIImage(named: "randomNews")!,
                    publishedAt: "any_date",
                    content: "any-content")
}

func anyCategoryInput() -> CategoryInput {
    return CategoryInput(queryBy: .topHeadlines, sortBy: .relevancy)
}

func anyNewsInput() -> NewsInput {
    return NewsInput(query: "any-query", sortBy: .relevancy)
}

// MARK: - Equatable

extension NewsOutput: Equatable {
    public static func == (lhs: NewsOutput, rhs: NewsOutput) -> Bool {
        return lhs.totalResults == rhs.totalResults &&
        lhs.articles == rhs.articles &&
        lhs.status == rhs.status
    }
}

extension Article: Equatable {
    public static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.source == rhs.source &&
        lhs.author == rhs.author &&
        lhs.title == rhs.title &&
        lhs.description == rhs.description &&
        lhs.url == rhs.url &&
        lhs.urlToImage == rhs.urlToImage &&
        lhs.publishedAt == rhs.publishedAt &&
        lhs.content == rhs.content
    }
}

extension SourceItem: Equatable {
    public static func == (lhs: SourceItem, rhs: SourceItem) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name
    }
}
