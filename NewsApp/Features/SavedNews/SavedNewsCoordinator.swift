//
//  SavedNewsCoordinator.swift
//  NewsApp
//
//  Created by Vitor Boff on 22/05/24.
//

import UIKit

public final class NASavedNewsCoordinator: NASavedNewsCoordinatorInterface {

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
        let interactor = NASavedNewsInteractor()
        let presenter = NASavedNewsPresenter(coordinator: self,
                                        interactor: interactor)
        let viewController = NASavedNewsViewController(presenter: presenter)
        viewController.modalPresentationStyle = .fullScreen

        navigator?.pushViewController(viewController, animated: true)
    }
    
    func initWithNewNavigator() -> UINavigationController {
        let newNavigator = UINavigationController()
        newNavigator.viewControllers = [initViewController()]
        navigator = newNavigator
        return newNavigator
    }
    
    func navigateToDetails(news: NewsItem) {
        guard let navigator else { return }
        router.showNewsDetails(navigator: navigator, newsDetails: news)
    }
    
    // MARK: - Private Methods
    
    private func initViewController() -> NASavedNewsViewController {
        let interactor = NASavedNewsInteractor()
        let presenter = NASavedNewsPresenter(coordinator: self, interactor: interactor)
        return NASavedNewsViewController(presenter: presenter)
    }
}

