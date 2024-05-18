//
//  HomeViewModelSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

@testable import NewsApp

final class NAHomeViewModelSpy: NAHomeViewModel {
    var setHeaderTitleCalled = false
    var setNewsSuccessCalled = false
    var setNewsFailedCalled = false
    var setLoadingCalled = false
    var removeLoadingCalled = false
    var headerText: String?
    var newsList: [NewsItem]?
    var messageError: String?
    
    func setHeaderTitle(_ text: String) {
        self.setHeaderTitleCalled = true
        self.headerText = text
    }
    
    func setNewsSuccess(newsList: [NewsItem]) {
        self.setNewsSuccessCalled = true
        self.newsList = newsList
    }
    
    func setNewsFailed(error: String) {
        self.setNewsFailedCalled = true
        self.messageError = error
    }
    
    func setLoading() {
        self.setLoadingCalled = true
    }
    
    func removeLoading() {
        self.removeLoadingCalled = true
    }
}

