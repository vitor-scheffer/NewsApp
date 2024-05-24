//
//  NewsInput.swift
//  NewsApp
//
//  Created by Vitor Boff on 23/05/24.
//

import Foundation

public struct NewsInput {
    let query: String
    let sortBy: String
    
    init(query: String, sortBy: SortType) {
        self.query = query
        self.sortBy = sortBy.rawValue
    }
}

extension NewsInput {
    func toDictionary() -> [String: String] {
        return [
            "q": self.query,
            "sortBy": self.sortBy,
            "from": Date.twoDaysAgo.ISO8601Format(),
            "searchIn": "title",
            "language": "en"
        ]
    }
}

public enum SortType: String {
    case relevancy = "relevancy"
    case popularity = "popularity"
}
