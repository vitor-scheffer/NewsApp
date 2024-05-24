//
//  HomeInteractorSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

@testable import NewsApp

final class NAHomeInteractorInputSpy: NAHomeInteractorInput {
    var api: NewsApiProtocol?
    var output: NAHomeInteractorOutput?
    
    var fetchNewsCalled = false
    
    func fetchNews() {
        self.fetchNewsCalled = true
    }
    
    func fetchNewsByQuery(_ input: NewsApp.CategoryInput) {
        
    }
}
