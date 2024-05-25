//
//  HomePresenter.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import UIKit
import Dispatch

final class NAHomePresenter: NAHomePresenterInterface {
    
    // MARK: Properties
    
    let coordinator: NAHomeCoordinatorInterface
    let interactor: NAHomeInteractorInput
    weak var viewModel: NAHomeViewModel?
    
    private var newsList: Array<NewsItem> = []
    private var querySearched: QueryType?
    
    // MARK: Initalizer
    
    init(
        coordinator: NAHomeCoordinatorInterface,
        interactor: NAHomeInteractorInput
    ) {
        self.coordinator = coordinator
        self.interactor = interactor
        self.interactor.output = self
    }
    
    // MARK: Methods
    
    func setViewModel(_ viewModel: NAHomeViewModel) {
        self.viewModel = viewModel
        viewModel.setHeaderTitle(I18n.General.appName.text)
        viewModel.setResultsTitle(I18n.Home.results.text)
        viewModel.setLoading(hasQuery: false)
        interactor.fetchNews()
    }
    
    func viewWillAppear(_ animated: Bool) {
        coordinator.navigator?.setNavigationBarHidden(true, animated: true)
    }
    
    func fetchNews() {
        clearNewsList()
        
        viewModel?.setLoading(hasQuery: true)
        interactor.fetchNews()
    }
    
    func newsSelected(_ input: NewsItem) {
        coordinator.navigateToDetails(news: input)
    }
    
    func fetchNewsByQuery(_ input: QueryType) {
        viewModel?.setLoading(hasQuery: true)
        clearNewsList()
        
        self.querySearched = input
        let newsInput = CategoryInput(queryBy: input, sortBy: .relevancy)
        interactor.fetchNewsByQuery(newsInput)
    }
    
    private func clearNewsList() {
        self.newsList = []
    }
}

// MARK: - NAHomeInteractorOutput

extension NAHomePresenter: NAHomeInteractorOutput {
    func fetchNewsSucceeded(_ output: NewsOutput, hasQuery: Bool) {
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
            switch hasQuery {
            case true:
                guard let querySelected = self.querySearched else { return }
                var resultText: String
                
                switch querySelected {
                case.sports:
                    resultText = I18n.Home.sports.text
                case .stocks:
                    resultText = I18n.Home.stocks.text
                case .entertainment:
                    resultText = I18n.Home.entertainment.text
                default:
                    resultText = I18n.Home.results.text
                }
                
                self.viewModel?.setNewsByQuerySuccess(newsList: self.newsList, querySearched: resultText)
            default:
                self.viewModel?.setNewsSuccess(newsList: self.newsList)
            }
            
            self.viewModel?.removeLoading()
        }
    }
    
    func fetchNewsFailed(_ output: String) {
        self.viewModel?.setNewsFailed(error: output)
    }
}
