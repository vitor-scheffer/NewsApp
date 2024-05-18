//
//  HomeProtocol.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import UIKit

protocol NAHomeViewModel: AnyObject {
    func setHeaderTitle(_ text: String)
    func setNewsSuccess(newsList: [NewsItem])
    func setNewsFailed(error: String)
    func setLoading()
    func removeLoading()
}

protocol NAHomePresenterInterface: AnyObject {
    var coordinator: NAHomeCoordinatorInterface { get }
    var interactor: NAHomeInteractorInput { get }
    var viewModel: NAHomeViewModel? { get }
    func setViewModel(_ viewModel: NAHomeViewModel)
    func viewWillAppear(_ animated: Bool)
    func newsSelected(_ input: NewsItem)
}

protocol NAHomeInteractorOutput: AnyObject {
    func fetchNewsSucceeded(_ output: NewsOutput)
    func fetchNewsFailed(_ output: String)
}

protocol NAHomeInteractorInput: AnyObject {
    var api: NewsApiProtocol? { get set }
    var output: NAHomeInteractorOutput? { get set }
    func fetchNews()
}

protocol NAHomeCoordinatorInterface: AnyObject {
    var navigator: UINavigationController? { get }
    func start()
    func navigateToDetails(news: NewsItem)
}
