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

func anyNewsDetails() -> NewsItem {
    return NewsItem(id: "any-id",
                    author: "any-author",
                    title: "any-title",
                    description: "any-description",
                    image: UIImage(named: "randomNews")!,
                    publishedAt: "any_date",
                    content: "any-content")
}
