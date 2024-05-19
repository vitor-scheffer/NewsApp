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
    
    func fetchNewsSucceeded(_ output: NewsOutput) {
        self.fetchNewsSucceededCalled = true
        self.newsList = output
    }
    
    func fetchNewsFailed(_ output: String) {
        self.fetchNewsFailedCalled = true
        self.messageError = output
    }
}
