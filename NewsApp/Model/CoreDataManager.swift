//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Vitor Boff on 21/05/24.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: CoreDataManagerProtocol {
    
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    func saveNews(news: NewsItem, completion: @escaping (Result<Void, CoreDataError>) -> Void) {
        let newNews = News(context: context)
        newNews.author = news.author
        newNews.content = news.content
        newNews.descript = news.description
        newNews.id = news.id
        newNews.publishedAt = news.publishedAt
        newNews.title = news.title
        newNews.image = news.image.jpegData(compressionQuality: 1.0)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.save(message: error.localizedDescription)))
        }
    }
    
    func deleteNews(byId id: String, completion: @escaping (Result<Void, CoreDataError>) -> Void) {
        let request: NSFetchRequest<News> = News.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            if let newsToDelete = try context.fetch(request).first {
                context.delete(newsToDelete)
                try context.save()
                completion(.success(()))
            } else {
                let error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "News with ID \(id) not found"])
                completion(.failure(.delete(message: error.localizedDescription)))
            }
        } catch {
            completion(.failure(.delete(message: error.localizedDescription)))
        }
    }
    
    func fetchNews(completion: @escaping (Result<[News], CoreDataError>) -> Void) {
        let request: NSFetchRequest<News> = News.fetchRequest()
        
        do {
            let newsArray = try context.fetch(request)
            completion(.success(newsArray))
        } catch {
            completion(.failure(.fetch(message: error.localizedDescription)))
        }
    }
    
    func fetchNews(byId id: String, completion: @escaping (Result<News?, CoreDataError>) -> Void) {
        let request: NSFetchRequest<News> = News.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            if let news = try context.fetch(request).first {
                completion(.success(news))
            } else {
                completion(.failure(.fetchByID(message: "News with ID \(id) not found")))
            }
        } catch {
            completion(.failure(.fetchByID(message: error.localizedDescription)))
        }
    }
}
