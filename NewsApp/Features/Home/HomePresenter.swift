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
    
    func navigateToDetails() {
        coordinator.navigateToDetails()
    }
}

// MARK: - NAHomeInteractorOutput

extension NAHomePresenter: NAHomeInteractorOutput {
    func fetchNewsSucceeded(_ output: NewsOutput) {
        viewModel?.setNewsSuccess(news: output)
    }
    
    func fetchNewsFailed(_ output: String) {
        viewModel?.setNewsFailed(error: output)
    }
}

