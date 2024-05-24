//
//  CategoryInput.swift
//  NewsApp
//
//  Created by Vitor Boff on 24/05/24.
//

import Foundation

public struct CategoryInput {
    let queryBy: String
    let sortBy: String
    
    init(queryBy: QueryType, sortBy: SortType) {
        self.queryBy = queryBy.rawValue
        self.sortBy = sortBy.rawValue
    }
}

extension CategoryInput {
    func toDictionary() -> [String: String] {
        return [
            "q": self.queryBy,
            "sortBy": self.sortBy,
            "from": Date.twoDaysAgo.ISO8601Format(),
            "language": "en"
        ]
    }
}

public enum QueryType: String {
    case sports = "NBA"
    case entertainment = "Hollywood"
    case stocks = "Stocks"
}
