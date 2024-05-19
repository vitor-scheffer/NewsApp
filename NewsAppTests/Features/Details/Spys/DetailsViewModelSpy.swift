//
//  DetailsViewModelSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

@testable import NewsApp

final class NADetailsViewModelSpy: NADetailsViewModel {
    var setLoadingCalled = false
    var removeLoadingCalled = false
    var setupLayoutCalled = false
    var newsDetails: NewsItem?
    
    func setLoading() {
        self.setLoadingCalled = true
    }
    
    func removeLoading() {
        self.removeLoadingCalled = true
    }
    
    func setupLayout(newsDetails: NewsItem) {
        self.setupLayoutCalled = true
        self.newsDetails = newsDetails
    }
}
