//
//  SearchPresenter.swift
//  NewsApp
//
//  Created by Vitor Boff on 24/05/24.
//

import UIKit
import Dispatch

final class NASearchPresenter: NASearchPresenterInterface {
    
    // MARK: Properties
    
    let coordinator: NASearchCoordinatorInterface
    let interactor: NASearchInteractorInput
    weak var viewModel: NASearchViewModel?
    
    private var newsList: [NewsItem] = []
    private var querySearched: String?
    
    // MARK: Initalizer
    
    init(
        coordinator: NASearchCoordinatorInterface,
        interactor: NASearchInteractorInput
    ) {
        self.coordinator = coordinator
        self.interactor = interactor
        self.interactor.output = self
    }
    
    // MARK: Methods
    
    func setViewModel(_ viewModel: NASearchViewModel) {
        self.viewModel = viewModel
        viewModel.setHeaderTitle(I18n.General.appName.text)
        viewModel.setSearchMessage(nil, message: I18n.Search.message.text)
    }
    
    func viewWillAppear(_ animated: Bool) {
        coordinator.navigator?.setNavigationBarHidden(true, animated: true)
    }
    
    func newsSelected(_ input: NewsItem) {
        coordinator.navigateToDetails(news: input)
    }
    
    func fetchNewsByQuery(_ input: String) {
        viewModel?.setLoading()
        clearNewsList()
        
        self.querySearched = input
        let newsInput = NewsInput(query: input, sortBy: .relevancy)
        interactor.fetchNewsByQuery(newsInput)
    }
    
    private func clearNewsList() {
        self.newsList = []
    }
}

// MARK: - NASearchInteractorOutput

extension NASearchPresenter: NASearchInteractorOutput {
    func fetchNewsSucceeded(_ output: NewsOutput) {
        let group = DispatchGroup()
        
        output.articles.forEach { article in
            
            if article.isPresentable() {
                group.enter()
                ImageManager().fetchImage(url: article.urlToImage) { [weak self] image in
                    guard let self = self else { return }
                    
                    let formattedDate = article.publishedAt.isoFormatter()
                    
                    let news = NewsItem(
                        id: article.title.generateID(),
                        author: I18n.Home.author.text(with: article.author!),
                        title: article.title,
                        description: article.description,
                        image: image!,
                        publishedAt: formattedDate,
                        content: article.content
                    )
                    
                    self.newsList.append(news)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            guard let queryText = self.querySearched else { return }
            self.viewModel?.setNewsByQuerySuccess(newsList: self.newsList, querySearched: queryText)
            
            self.viewModel?.removeLoading()
        }
    }
    
    
    func fetchNewsFailed(_ output: String) {
        self.viewModel?.setNewsFailed(error: output)
    }
    
    func fetchNewsSucceededWithEmptyList() {
        self.viewModel?.removeLoading()
        
        guard let queryText = self.querySearched else { return }
        self.viewModel?.setSearchMessage(queryText, message: I18n.Search.empty.text)
    }
}
