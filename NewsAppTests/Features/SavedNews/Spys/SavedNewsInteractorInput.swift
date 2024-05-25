//
//  SavedNewsInteractorInput.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 25/05/24.
//

@testable import NewsApp

final class NASavedNewsInteractorInputSpy: NASavedNewsInteractorInput {
    var api: CoreDataManagerProtocol?
    var output: NASavedNewsInteractorOutput?
    
    var fetchNewsCalled = false
    
    func fetchNews() {
        self.fetchNewsCalled = true
    }
}
