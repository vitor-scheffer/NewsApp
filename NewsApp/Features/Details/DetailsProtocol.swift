//
//  DetailsProtocol.swift
//  NewsApp
//
//  Created by Vitor Boff on 18/05/24.
//

import UIKit

protocol NADetailsViewModel: AnyObject {
    func setupLayout(newsDetails: NewsItem)
}

protocol NADetailsPresenterInterface: AnyObject {
    var coordinator: NADetailsCoordinatorInterface { get }
    var viewModel: NADetailsViewModel? { get }
    func setViewModel(_ viewModel: NADetailsViewModel)
    func viewWillAppear(_ animated: Bool)
    func navigateToHome()
}

protocol NADetailsCoordinatorInterface: AnyObject {
    var navigator: UINavigationController? { get }
    func start()
    func navigateToHome()
}
