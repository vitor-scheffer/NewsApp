//
//  SavedNewsViewModelSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 25/05/24.
//

@testable import NewsApp

final class NASavedNewsViewModelSpy: NASavedNewsViewModel {
    var setHeaderTitleCalled = false
    var setNewsSuccessCalled = false
    var setNewsFailedCalled = false
    var setLoadingCalled = false
    var removeLoadingCalled = false
    var setNewsListEmptyCalled = false
    var headerText: String?
    var newsList: Array<NewsItem>?
    var messageError: String?
    
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
    
    func setNewsListEmpty() {
        self.setNewsListEmptyCalled = true
    }
    
    func setLoading() {
        self.setLoadingCalled = true
    }
    
    func removeLoading() {
        self.removeLoadingCalled = true
    }
}
