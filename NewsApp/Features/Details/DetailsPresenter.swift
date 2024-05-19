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
}
