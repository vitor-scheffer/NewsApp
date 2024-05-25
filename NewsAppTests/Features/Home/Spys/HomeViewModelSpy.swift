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
    var setNewsByQuerySuccessCalled = false
    var setNewsFailedCalled = false
    var setLoadingCalled = false
    var removeLoadingCalled = false
    var headerText: String?
    var newsList: Array<NewsItem>?
    var messageError: String?
    var querySearched: String?
    
    func setHeaderTitle(_ text: String) {
        self.setHeaderTitleCalled = true
        self.headerText = text
    }
    
    func setNewsSuccess(newsList: Array<NewsItem>) {
        self.setNewsSuccessCalled = true
        self.newsList = newsList
    }
    
    func setNewsFailed(error: String) {
        self.setNewsFailedCalled = true
        self.messageError = error
    }
    
    func setLoading(hasQuery: Bool) {
        self.setLoadingCalled = true
    }
    
    func removeLoading() {
        self.removeLoadingCalled = true
    }
    
    func setResultsTitle(_ text: String) {
        
    }
    
    func setNewsByQuerySuccess(newsList: Array<NewsItem>, querySearched: String) {
        self.setNewsByQuerySuccessCalled = true
        self.newsList = newsList
        self.querySearched = querySearched
    }
}
