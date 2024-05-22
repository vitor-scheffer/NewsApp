//
//  NADetailsPresenter.swift
//  NewsApp
//
//  Created by Vitor Boff on 18/05/24.
//

import UIKit

final class NADetailsPresenter: NADetailsPresenterInterface {
    
    // MARK: Properties
    
    let coordinator: NADetailsCoordinatorInterface
    weak var viewModel: NADetailsViewModel?
    
    private var news: NewsItem
    
    // MARK: Initalizer
    
    init(
        coordinator: NADetailsCoordinatorInterface,
        news: NewsItem
    ) {
        self.coordinator = coordinator
        self.news = news
    }
    
    // MARK: Methods
    
    func setViewModel(_ viewModel: NADetailsViewModel) {
        self.viewModel = viewModel
        viewModel.setupLayout(newsDetails: news)
    }
    
    func viewWillAppear(_ animated: Bool) {
        coordinator.navigator?.setNavigationBarHidden(false, animated: true)
    }
    
    func navigateToHome() {
        coordinator.navigateToHome()
    }
    
    func bookmarkAction(_ sender: UIBarButtonItem) {
        let source = UserDefaults.standard
        
        if sender.image == UIImage(systemName: "bookmark") {
            CoreDataManager.shared.saveNews(news: news) { result in
                switch result {
                case .success:
                    source.set(true, forKey: self.news.id)
                    self.viewModel?.setNewsSaveSucceeded(key: self.news.id)
                case .failure(let error):
                    self.viewModel?.setErrorAlert(error.message)
                }
            }
            return
        }
        
        CoreDataManager.shared.deleteNews(byId: self.news.id) { result in
            switch result {
            case .success:
                source.set(false, forKey: self.news.id)
                self.viewModel?.setNewsRemoveSucceeded(key: self.news.id)
            case .failure(let error):
                self.viewModel?.setErrorAlert(error.message)
            }
        }
    }
    
    func verifyNewsIsSaved(key: String) {
        let source = UserDefaults.standard
        let isSaved = source.bool(forKey: key)
        
        viewModel?.setupNavigationView(isSaved)
    }
}
