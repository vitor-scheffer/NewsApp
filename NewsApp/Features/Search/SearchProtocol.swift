//
//  SearchProtocol.swift
//  NewsApp
//
//  Created by Vitor Boff on 24/05/24.
//

import UIKit

protocol NASearchViewModel: AnyObject {
    func setHeaderTitle(_ text: String)
    func setNewsByQuerySuccess(newsList: [NewsItem], querySearched: String)
    func setSearchMessage(_ querySearched: String?, message: String)
    func setNewsFailed(error: String)
    func setLoading()
    func removeLoading()
}

protocol NASearchPresenterInterface: AnyObject {
    var coordinator: NASearchCoordinatorInterface { get }
    var interactor: NASearchInteractorInput { get }
    var viewModel: NASearchViewModel? { get }
    func setViewModel(_ viewModel: NASearchViewModel)
    func viewWillAppear(_ animated: Bool)
    func newsSelected(_ input: NewsItem)
    func fetchNewsByQuery(_ input: String)
}

protocol NASearchInteractorOutput: AnyObject {
    func fetchNewsSucceeded(_ output: NewsOutput)
    func fetchNewsFailed(_ output: String)
    func fetchNewsSucceededWithEmptyList()
}

protocol NASearchInteractorInput: AnyObject {
    var api: NewsApiProtocol? { get set }
    var output: NASearchInteractorOutput? { get set }
    func fetchNewsByQuery(_ input: NewsInput)
}

protocol NASearchCoordinatorInterface: AnyObject {
    var navigator: UINavigationController? { get }
    func start()
    func navigateToDetails(news: NewsItem)
}
