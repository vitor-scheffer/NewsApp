//
//  SavedNewsPresenterSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 25/05/24.
//

@testable import NewsApp

final class NASavedNewsPresenterSpy: NASavedNewsPresenterInterface {
    var coordinator: NASavedNewsCoordinatorInterface = NASavedNewsCoordinatorSpy()
    var interactor: NASavedNewsInteractorInput = NASavedNewsInteractorInputSpy()
    var viewModel: NASavedNewsViewModel?
    
    var setViewModelCalled = false
    var fetchSearchCalled = false
    var viewWillAppearCalled = false
    var newsSelectedCalled = false
    var news: NewsItem?
    var searchedText: String?
    
    func setViewModel(_ viewModel: any NASavedNewsViewModel) {
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
    
    func fetchSearch(_ forText: String) {
        self.fetchSearchCalled = true
        self.searchedText = forText
    }
}
