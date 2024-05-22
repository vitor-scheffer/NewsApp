//
//  HomeCoordinator.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import UIKit

public final class NAHomeCoordinator: NAHomeCoordinatorInterface {

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
        let interactor = NAHomeInteractor()
        let presenter = NAHomePresenter(coordinator: self,
                                        interactor: interactor)
        let viewController = NAHomeViewController(presenter: presenter)
        viewController.modalPresentationStyle = .fullScreen
        viewController.title = I18n.General.appName.text

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
    
    private func initViewController() -> NAHomeViewController {
        let interactor = NAHomeInteractor()
        let presenter = NAHomePresenter(coordinator: self, interactor: interactor)
        return NAHomeViewController(presenter: presenter)
    }
}
