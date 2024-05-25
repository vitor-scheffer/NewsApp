//
//  CoreDataManagerProtocol.swift
//  NewsApp
//
//  Created by Vitor Boff on 21/05/24.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    func saveNews(news: NewsItem, completion: @escaping (Result<Void, CoreDataError>) -> Void)
    func deleteNews(byId id: String, completion: @escaping (Result<Void, CoreDataError>) -> Void)
    func fetchNews(completion: @escaping (Result<Array<News>, CoreDataError>) -> Void)
    func fetchNews(byId id: String, completion: @escaping (Result<News?, CoreDataError>) -> Void)
}

public enum CoreDataError: Error {
    case save(message: String)
    case delete(message: String)
    case fetch(message: String)
    case fetchByID(message: String)
    
    public var message: String {
        switch self {
        case .save(message: let message):
            return I18n.CoreDataError.save.text(with: message)
        case .delete(message: let message):
            return I18n.CoreDataError.delete.text(with: message)
        case .fetch(message: let message):
            return I18n.CoreDataError.fetch.text(with: message)
        case .fetchByID(message: let message):
            return I18n.CoreDataError.fetchByID.text(with: message)
        }
    }
}
