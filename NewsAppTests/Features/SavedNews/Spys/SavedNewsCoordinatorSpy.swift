//
//  SavedNewsCoordinatorSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 25/05/24.
//

import UIKit
@testable import NewsApp

final class NASavedNewsCoordinatorSpy: NASavedNewsCoordinatorInterface {
    var navigator: UINavigationController?
    
    var startCalled = false
    var navigateToDetailsCalled = false
    var news: NewsItem?
    
    func start() {
        self.startCalled = true
    }
    
    func navigateToDetails(news: NewsItem) {
        self.navigateToDetailsCalled = true
        self.news = news
    }
}
