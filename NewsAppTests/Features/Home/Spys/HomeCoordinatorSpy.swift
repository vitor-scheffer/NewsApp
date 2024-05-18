//
//  HomeCoordinatorSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

import UIKit
@testable import NewsApp

final class NAHomeCoordinatorSpy: NAHomeCoordinatorInterface {
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
