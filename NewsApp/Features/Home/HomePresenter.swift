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
        fetchNews()
    }
    
    func viewWillAppear(_ animated: Bool) {
        coordinator.navigator?.setNavigationBarHidden(false, animated: true)
    }
    
    func fetchNews() {
        interactor.fetchNews()
    }
    
    func navigateToDetails(_ input: NewsItem) {
        coordinator.navigateToDetails(news: input)
    }
}

// MARK: - NAHomeInteractorOutput

extension NAHomePresenter: NAHomeInteractorOutput {
    func fetchNewsSucceeded(_ output: NewsOutput) {
        let group = DispatchGroup()
        
        output.articles.forEach { article in
            group.enter()
            ImageManager().fetchImage(url: article.urlToImage) { [weak self] image in
                guard let self = self else { return }
                
                let formattedDate = article.publishedAt.isoFormatter()
                
                let news = NewsItem(
                    id: article.source.id,
                    author: article.author,
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
        
        group.notify(queue: .main) {
            self.viewModel?.setNewsSuccess(newsList: self.newsList)
        }
    }
    
    
    func fetchNewsFailed(_ output: String) {
        DispatchQueue.main.async {
            self.viewModel?.setNewsFailed(error: output)
        }
    }
}

