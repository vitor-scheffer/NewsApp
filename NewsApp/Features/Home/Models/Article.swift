//
//  Article.swift
//  NewsApp
//
//  Created by Vitor Boff on 17/05/24.
//

import Foundation

public struct Article: Decodable {
    public let source: SourceItem
    public let author: String?
    public let title: String
    public let description: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String
    public let content: String?
}

extension Article {
    func isPresentable() -> Bool {
        return !self.title.contains("[Removed]")
        && self.author != nil
        && self.author != ""
        && self.description != nil
        && self.urlToImage != nil
    }
}

public struct SourceItem: Decodable {
    let id: String?
    let name: String?
}
