//
//  HomePresenterSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

@testable import NewsApp

final class NAHomePresenterSpy: NAHomePresenterInterface {
    var coordinator: NAHomeCoordinatorInterface = NAHomeCoordinatorSpy()
    var interactor: NAHomeInteractorInput = NAHomeInteractorInputSpy()
    var viewModel: NAHomeViewModel?
    
    var setViewModelCalled = false
    var viewWillAppearCalled = false
    var newsSelectedCalled = false
    var news: NewsItem?
    
    func setViewModel(_ viewModel: any NAHomeViewModel) {
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
}
