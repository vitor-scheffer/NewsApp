//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Vitor Boff on 24/05/24.
//

import UIKit

class NASearchViewController: NABaseViewController {
    
    // MARK: Properties
    
    private let presenter: NASearchPresenterInterface
    private var skeletonTitleView: NASkeletonView?
    private var skeletonTableView: NASkeletonView?
    private var emptyList: NALabel?
    
    private var newsList: Array<NewsItem> = [] {
        didSet {
            tableView.reloadData()
            tableView.scrollToTopCell()
        }
    }
    
    private lazy var titleLabel = {
        let view = NALabel(.title)
        return view
    }()
    
    private lazy var resultTitleLabel = {
        let view = NALabel(.title3)
        return view
    }()
    
    private var searchView = {
        let view = UISearchBar()
        view.barTintColor = NAColor.body1.uiColor
        view.layer.borderWidth = 1
        view.layer.borderColor = NAColor.body1.cgColor
        view.placeholder = I18n.TabBar.search.text
        view.searchTextField.backgroundColor = NAColor.white.uiColor
        return view
    }()
    
    private lazy var tableView = {
        let view = UITableView()
        return view
    }()

    // MARK: Initializer

    init(presenter: NASearchPresenterInterface) {
        self.presenter = presenter

        super.init()
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        presenter.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter.setViewModel(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
    }
}

extension NASearchViewController: NASearchViewModel {
    func setLoading() {
        resultTitleLabel.isHidden = true
        tableView.isHidden = true
        emptyList?.removeFromSuperview()
        emptyList = nil
        
        let skeletonTitleView = NASkeletonView([.singleLine], height: 30)
        let skeletonTableView = NASkeletonView([.newsList], quantity: 4)
        
        view.addSubviews([skeletonTitleView, skeletonTableView], constraints: true)
        
        skeletonTitleView.nac
            .top(searchView.bottomAnchor, 32)
            .leading(16)
            .trailing(16)
        
        skeletonTableView.nac
            .top(skeletonTitleView.bottomAnchor, 32)
            .leading(16)
            .trailing(16)
        
        self.skeletonTitleView = skeletonTitleView
        self.skeletonTableView = skeletonTableView
    }
    
    func removeLoading() {
        skeletonTitleView?.removeFromSuperview()
        skeletonTableView?.removeFromSuperview()
        skeletonTitleView = nil
        skeletonTableView = nil
        
        resultTitleLabel.isHidden = false
        tableView.isHidden = false
    }
    
    func setHeaderTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setNewsByQuerySuccess(newsList: Array<NewsItem>, querySearched: String) {
        resultTitleLabel.text = I18n.Search.resultsQuery.text(with: querySearched)
        self.newsList = newsList
    }
    
    func setSearchMessage(_ querySearched: String?, message: String) {
        if let querySearched { resultTitleLabel.text = I18n.Search.resultsQuery.text(with: querySearched) }
        
        tableView.isHidden = true
        
        emptyList = NALabel(.description)
        emptyList?.text = message
        emptyList?.textAlignment = .center
        
        if let emptyList {
            self.view.addSubview(emptyList, constraints: true)
            
            emptyList.nac
                .centerY(self.view.safeAreaLayoutGuide.centerYAnchor)
                .leading(16)
                .trailing(16)
        }
    }
    
    func setNewsFailed(error: String) {
        addAlert(title: I18n.APIError.title.text, message: error, cancelAction: I18n.APIError.ok.text)
    }
}

extension NASearchViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NANewsViewCell.reuseIdentifier,
                                                       for: indexPath) as? NANewsViewCell else {
            return UITableViewCell()
        }

        cell.setup(news: newsList[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.newsSelected(newsList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension NASearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let inputSearch = searchBar.text {presenter.fetchNewsByQuery(inputSearch)}
    }
}

// MARK: ViewCode

extension NASearchViewController: ViewCode {
    func buildHierarchy() {
        view.addSubviews([titleLabel, searchView, resultTitleLabel, tableView], constraints: true)
    }
    
    func setupConstraints() {
        titleLabel.nac
            .top(view.safeAreaLayoutGuide.topAnchor)
            .leading(16)
            .trailing(16)
        
        searchView.nac
            .top(titleLabel.bottomAnchor)
            .leading(8)
            .trailing(8)
        
        resultTitleLabel.nac
            .top(searchView.bottomAnchor, 32)
            .leading(16)
            .trailing(16)
        
        tableView.nac
            .top(resultTitleLabel.bottomAnchor, 12)
            .leading()
            .trailing()
            .bottom()
    }
    
    func applyAdditionalChanges() {
        searchView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NANewsViewCell.self, forCellReuseIdentifier: NANewsViewCell.reuseIdentifier)
        tableView.backgroundColor = NAColor.body1.uiColor
    }
}

#Preview("NASearchViewController") {
    NASearchViewController(presenter: NASearchPresenter(coordinator: NASearchCoordinator(), interactor: NASearchInteractor()))
}
