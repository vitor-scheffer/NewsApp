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
    
    private var newsList: [NewsItem] = []
    private var querySearched: String?
    
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
    }
    
    func viewWillAppear(_ animated: Bool) {
        viewModel?.setLoading(hasQuery: false)
        coordinator.navigator?.setNavigationBarHidden(true, animated: true)
        
        fetchNews()
    }
    
    func fetchNews() {
        clearNewsList()
        
        interactor.fetchNews()
    }
    
    func newsSelected(_ input: NewsItem) {
        coordinator.navigateToDetails(news: input)
    }
    
    func fetchNewsByQuery(_ input: String) {
        viewModel?.setLoading(hasQuery: true)
        clearNewsList()
        
        self.querySearched = input
        let newsInput = NewsInput(query: input, sortBy: .relevancy)
        interactor.fetchNewsByQuery(newsInput)
    }
    
    private func isPresentable(article: Article) -> Bool {
        return !article.title.contains("[Removed]")
        && article.author != nil
        && article.author != ""
        && article.description != nil
        && article.urlToImage != nil
    }
    
    private func generateID(forKey: String) -> String {
        let source = UserDefaults.standard
        
        if let storageID = source.string(forKey: forKey) {
            return storageID
        }
        
        let generatedID = UUID().uuidString
        source.set(generatedID, forKey: forKey)
        
        return generatedID
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
            
            if isPresentable(article: article) {
                group.enter()
                ImageManager().fetchImage(url: article.urlToImage) { [weak self] image in
                    guard let self = self else { return }
                    
                    let formattedDate = article.publishedAt.isoFormatter()
                    
                    let news = NewsItem(
                        id: generateID(forKey: article.title),
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
                guard let queryText = self.querySearched else { return }
                self.viewModel?.setNewsByQuerySuccess(newsList: self.newsList, querySearched: queryText)
            default:
                self.viewModel?.setNewsSuccess(newsList: self.newsList)
            }
            
            self.viewModel?.removeLoading()
        }
    }
    
    
    func fetchNewsFailed(_ output: String) {
        self.viewModel?.setNewsFailed(error: output)
    }
    
    func fetchNewsSucceededWithEmptyList() {
        self.viewModel?.removeLoading()
        self.viewModel?.setSearchEmptyList()
    }
}
