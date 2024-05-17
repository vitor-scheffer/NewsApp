//
//  HomeCoordinator.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import UIKit

protocol NAHomeDelegate: AnyObject {
    func showDetails(_ navigator: UINavigationController?,
                                id: Int)
}

public final class NAHomeCoordinator: NAHomeCoordinatorInterface {

    // MARK: Properties

    var navigator: UINavigationController?
    private let router: NARouterProtocol
    weak var delegate: NAHomeDelegate?

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

        navigator?.present(viewController, animated: true)
    }
    
    func navigateToDetails() {
        guard let navigator else { return }
        delegate?.showDetails(navigator, id: 0)
    }
}

