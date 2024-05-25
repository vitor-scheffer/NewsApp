//
//  HomeInteractorOutputSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

@testable import NewsApp

final class NAHomeInteractorOutputSpy: NAHomeInteractorOutput {
    var fetchNewsSucceededCalled = false
    var fetchNewsFailedCalled = false
    var newsList: NewsOutput?
    var messageError: String?
    var hasQuery: Bool?
    
    func fetchNewsFailed(_ output: String) {
        self.fetchNewsFailedCalled = true
        self.messageError = output
    }
    
    func fetchNewsSucceeded(_ output: NewsOutput, hasQuery: Bool) {
        self.fetchNewsSucceededCalled = true
        self.newsList = output
        self.hasQuery = hasQuery
    }
}
