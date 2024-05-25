//
//  SearchInteractorInputSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 25/05/24.
//

@testable import NewsApp

final class NASearchInteractorInputSpy: NASearchInteractorInput {
    var api: NewsApiProtocol?
    var output: NASearchInteractorOutput?
    
    var fetchNewsByQueryCalled = false
    var input: NewsInput?
    
    func fetchNewsByQuery(_ input: NewsInput) {
        self.fetchNewsByQueryCalled = true
        self.input = input
    }
}
