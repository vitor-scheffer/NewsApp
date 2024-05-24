//
//  SavedNewsPresenter.swift
//  NewsApp
//
//  Created by Vitor Boff on 22/05/24.
//

import UIKit

final class NASavedNewsPresenter: NASavedNewsPresenterInterface {
    
    // MARK: Properties
    
    let coordinator: NASavedNewsCoordinatorInterface
    let interactor: NASavedNewsInteractorInput
    weak var viewModel: NASavedNewsViewModel?
    
    private var newsList: [NewsItem] = []
    
    // MARK: Initalizer
    
    init(
        coordinator: NASavedNewsCoordinatorInterface,
        interactor: NASavedNewsInteractorInput
    ) {
        self.coordinator = coordinator
        self.interactor = interactor
        self.interactor.output = self
    }
    
    // MARK: Methods
    
    func setViewModel(_ viewModel: NASavedNewsViewModel) {
        self.viewModel = viewModel
        viewModel.setHeaderTitle(I18n.General.appName.text)
        viewModel.setLoading()
    }
    
    func viewWillAppear(_ animated: Bool) {
        coordinator.navigator?.setNavigationBarHidden(true, animated: true)
        fetchNews()
    }
    
    func fetchNews() {
        self.newsList = []
        
        interactor.fetchNews()
    }
    
    func newsSelected(_ input: NewsItem) {
        coordinator.navigateToDetails(news: input)
    }
}

// MARK: - NASavedNewsInteractorOutput

extension NASavedNewsPresenter: NASavedNewsInteractorOutput {
    func fetchNewsSucceededWithEmptyList() {
        viewModel?.removeLoading()
        viewModel?.setNewsListEmpty()
    }
    
    func fetchNewsSucceeded(_ output: [News]) {
        output.forEach { data in
            guard let id = data.id,
                  let title = data.title,
                  let image = data.image,
                  let publishedAt = data.publishedAt else { return }
            
            if let convertedImage = UIImage(data: image) {
                let newsItem = NewsItem(id: id,
                                        author: data.author,
                                        title: title,
                                        description: data.descript,
                                        image: convertedImage,
                                        publishedAt: publishedAt,
                                        content: data.content)
                
                newsList.append(newsItem)
                
                viewModel?.setNewsSuccess(newsList: self.newsList)
                viewModel?.removeLoading()
            }
        }
    }
    
    func fetchNewsFailed(_ output: String) {
        self.viewModel?.setNewsFailed(error: output)
    }
}

