//
//  DetailsCoordinator.swift
//  NewsApp
//
//  Created by Vitor Boff on 18/05/24.
//

import UIKit

public final class NADetailsCoordinator: NADetailsCoordinatorInterface {
    
    // MARK: Properties

    var navigator: UINavigationController?
    private let router: NARouterProtocol
    
    private var news: NewsItem

    // MARK: Initializer

    init(
        navigator: UINavigationController? = nil,
        router: NARouterProtocol = NARouter.shared,
        news: NewsItem
    ) {
        self.navigator = navigator
        self.router = router
        self.news = news
    }

    // MARK: Methods

    func start() {
        let presenter = NADetailsPresenter(coordinator: self, news: news)
        let viewController = NADetailsViewController(presenter: presenter)
        
        navigator?.pushViewController(viewController, animated: true)
    }
    
    func navigateToHome() {
        navigator?.popViewController(animated: true)
    }
}


