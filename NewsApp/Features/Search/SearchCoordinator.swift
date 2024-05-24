//
//  SearchCoordinator.swift
//  NewsApp
//
//  Created by Vitor Boff on 24/05/24.
//

import UIKit

public final class NASearchCoordinator: NASearchCoordinatorInterface {

    // MARK: Properties

    var navigator: UINavigationController?
    private let router: NARouterProtocol

    // MARK: Initializer

    init(navigator: UINavigationController? = nil, router: NARouterProtocol = NARouter.shared) {
        self.navigator = navigator
        self.router = router
    }

    // MARK: Methods

    func start() {
        let interactor = NASearchInteractor()
        let presenter = NASearchPresenter(coordinator: self,
                                        interactor: interactor)
        let viewController = NASearchViewController(presenter: presenter)
        viewController.modalPresentationStyle = .fullScreen
        viewController.title = I18n.General.appName.text

        navigator?.pushViewController(viewController, animated: true)
    }
    
    func navigateToDetails(news: NewsItem) {
        guard let navigator else { return }
        router.showNewsDetails(navigator: navigator, newsDetails: news)
    }
}
