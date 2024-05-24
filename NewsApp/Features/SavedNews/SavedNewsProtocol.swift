//
//  SavedNewsProtocol.swift
//  NewsApp
//
//  Created by Vitor Boff on 22/05/24.
//

import UIKit

protocol NASavedNewsViewModel: AnyObject {
    func setHeaderTitle(_ text: String)
    func setNewsSuccess(newsList: [NewsItem])
    func setNewsListEmpty()
    func setNewsFailed(error: String)
    func setLoading()
    func removeLoading()
}

protocol NASavedNewsPresenterInterface: AnyObject {
    var coordinator: NASavedNewsCoordinatorInterface { get }
    var interactor: NASavedNewsInteractorInput { get }
    var viewModel: NASavedNewsViewModel? { get }
    func setViewModel(_ viewModel: NASavedNewsViewModel)
    func viewWillAppear(_ animated: Bool)
    func newsSelected(_ input: NewsItem)
}

protocol NASavedNewsInteractorOutput: AnyObject {
    func fetchNewsSucceeded(_ output: [News])
    func fetchNewsFailed(_ output: String)
    func fetchNewsSucceededWithEmptyList()
}

protocol NASavedNewsInteractorInput: AnyObject {
    var api: NewsApiProtocol? { get set }
    var output: NASavedNewsInteractorOutput? { get set }
    func fetchNews()
}

protocol NASavedNewsCoordinatorInterface: AnyObject {
    var navigator: UINavigationController? { get }
    func start()
    func navigateToDetails(news: NewsItem)
}
