//
//  HomeProtocol.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import UIKit

protocol NAHomeViewModel: AnyObject {
    func setHeaderTitle(_ text: String)
    func setResultsTitle(_ text: String)
    func setNewsSuccess(newsList: [NewsItem])
    func setNewsByQuerySuccess(newsList: [NewsItem], querySearched: String)
    func setSearchEmptyList()
    func setNewsFailed(error: String)
    func setLoading(hasQuery: Bool)
    func removeLoading()
}

protocol NAHomePresenterInterface: AnyObject {
    var coordinator: NAHomeCoordinatorInterface { get }
    var interactor: NAHomeInteractorInput { get }
    var viewModel: NAHomeViewModel? { get }
    func setViewModel(_ viewModel: NAHomeViewModel)
    func viewWillAppear(_ animated: Bool)
    func newsSelected(_ input: NewsItem)
    func fetchNewsByQuery(_ input: String)
}

protocol NAHomeInteractorOutput: AnyObject {
    func fetchNewsSucceeded(_ output: NewsOutput, hasQuery: Bool)
    func fetchNewsFailed(_ output: String)
    func fetchNewsSucceededWithEmptyList()
}

protocol NAHomeInteractorInput: AnyObject {
    var api: NewsApiProtocol? { get set }
    var output: NAHomeInteractorOutput? { get set }
    func fetchNews()
    func fetchNewsByQuery(_ input: NewsInput)
}

protocol NAHomeCoordinatorInterface: AnyObject {
    var navigator: UINavigationController? { get }
    func start()
    func navigateToDetails(news: NewsItem)
}
