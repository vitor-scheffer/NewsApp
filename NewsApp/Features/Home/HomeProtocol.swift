//
//  HomeProtocol.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import UIKit

protocol NAHomeViewModel: AnyObject {
    func setHeaderTitle(_ text: String)
    func setNewsSuccess(remuneration: Double)
}

protocol NAHomePresenterInterface: AnyObject {
    var coordinator: NAHomeCoordinatorInterface { get }
    var interactor: NAHomeInteractorInput { get }
    var viewModel: NAHomeViewModel? { get }
    func setViewModel(_ viewModel: NAHomeViewModel)
    func viewWillAppear(_ animated: Bool)
    func fetchNews()
    func navigateToDetails()
}

protocol NAHomeInteractorOutput: AnyObject {
    func fetchNewsSucceeded(_output: NewsOutput)
    func fetchNewsFailed()
}

protocol NAHomeInteractorInput: AnyObject {
    var api: NewsApiProtocol? { get set }
    var output: NAHomeInteractorOutput? { get set }
    func fetchNews()
}

protocol NAHomeCoordinatorInterface: AnyObject {
    var navigator: UINavigationController? { get }
    func start()
    func navigateToDetails()
}
