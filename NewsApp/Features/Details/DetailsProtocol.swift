//
//  DetailsProtocol.swift
//  NewsApp
//
//  Created by Vitor Boff on 18/05/24.
//

import UIKit

protocol NADetailsViewModel: AnyObject {
    func setupLayout(newsDetails: NewsItem)
    func setNewsSaveSucceeded(key: String)
    func setNewsRemoveSucceeded(key: String)
    func setErrorAlert(_ error: String)
    func setupNavigationView(_ isSaved: Bool)
}

protocol NADetailsPresenterInterface: AnyObject {
    var coordinator: NADetailsCoordinatorInterface { get }
    var viewModel: NADetailsViewModel? { get }
    func setViewModel(_ viewModel: NADetailsViewModel)
    func viewWillAppear(_ animated: Bool)
    func verifyNewsIsSaved(key: String)
    func bookmarkAction(_ sender: UIBarButtonItem)
    func navigateToHome()
}

protocol NADetailsCoordinatorInterface: AnyObject {
    var navigator: UINavigationController? { get }
    func start()
    func navigateToHome()
}
