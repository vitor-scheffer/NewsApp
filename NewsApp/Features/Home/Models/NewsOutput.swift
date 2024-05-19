//
//  NewsOutput.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import Foundation

public struct NewsOutput: Decodable {
    public let status: String
    public let totalResults: Int
    public let articles: [Article]
    
    public init(status: String, totalResults: Int, articles: [Article]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}
