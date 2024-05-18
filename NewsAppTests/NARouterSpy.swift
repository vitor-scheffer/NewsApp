//
//  NARouterSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

import Foundation
import UIKit
@testable import NewsApp

final class NARouterSpy: NARouterProtocol {
    var navigator: UINavigationController?
    
    var showHomeCalled = false
    var showNewsDetailsCalled = false
    var newsDetails: NewsItem?
    
    func showHome(navigator: UINavigationController?) {
        self.navigator = navigator
        self.showHomeCalled = true
    }
    
    func showNewsDetails(navigator: UINavigationController?, newsDetails: NewsItem) {
        self.navigator = navigator
        self.showNewsDetailsCalled = true
        self.newsDetails = newsDetails
    }
    
    
}
