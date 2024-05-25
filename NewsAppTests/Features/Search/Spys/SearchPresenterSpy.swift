//
//  SearchPresenterSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 25/05/24.
//

@testable import NewsApp

final class NASearchPresenterSpy: NASearchPresenterInterface {
    var coordinator: NASearchCoordinatorInterface = NASearchCoordinatorSpy()
    var interactor: NASearchInteractorInput = NASearchInteractorInputSpy()
    var viewModel: NASearchViewModel?
    
    var setViewModelCalled = false
    var viewWillAppearCalled = false
    var newsSelectedCalled = false
    var fetchNewsByQueryCalled = false
    var news: NewsItem?
    var query: String?
    
    func setViewModel(_ viewModel: any NASearchViewModel) {
        self.setViewModelCalled = true
        self.viewModel = viewModel
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.viewWillAppearCalled = true
    }
    
    func newsSelected(_ input: NewsItem) {
        self.newsSelectedCalled = true
        self.news = input
    }
    
    func fetchNewsByQuery(_ input: String) {
        self.fetchNewsByQueryCalled = true
        self.query = input
    }
}
