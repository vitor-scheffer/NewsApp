//
//  SearchViewModelSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 25/05/24.
//

@testable import NewsApp

final class NASearchViewModelSpy: NASearchViewModel {
    var setHeaderTitleCalled = false
    var setNewsByQuerySuccessCalled = false
    var setNewsFailedCalled = false
    var setLoadingCalled = false
    var removeLoadingCalled = false
    var setSearchMessageCalled = false
    var headerText: String?
    var newsList: Array<NewsItem>?
    var messageError: String?
    var querySearched: String?
    var message: String?
    
    func setHeaderTitle(_ text: String) {
        self.setHeaderTitleCalled = true
        self.headerText = text
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
    
    func setNewsByQuerySuccess(newsList: Array<NewsItem>, querySearched: String) {
        self.setNewsByQuerySuccessCalled = true
        self.newsList = newsList
        self.querySearched = querySearched
    }
    
    func setSearchMessage(_ querySearched: String?, message: String) {
        self.setSearchMessageCalled = true
        self.querySearched = querySearched
        self.message = message
    }
}
