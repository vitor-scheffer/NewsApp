//
//  NewsItem.swift
//  NewsApp
//
//  Created by Vitor Boff on 17/05/24.
//

import Foundation
import UIKit

public struct NewsItem : Equatable {
    public let id: String
    public let author: String?
    public let title: String
    public let description: String?
    public let image: UIImage
    public let publishedAt: String
    public let content: String?
    
    init(
        id: String,
        author: String?,
        title: String,
        description: String?,
        image: UIImage,
        publishedAt: String,
        content: String?
    ) {
        self.id = id
        self.author = author
        self.title = title
        self.description = description
        self.image = image
        self.publishedAt = publishedAt
        self.content = content
    }
}
