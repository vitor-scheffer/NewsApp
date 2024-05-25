//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import UIKit

class NAHomeViewController: NABaseViewController {
    
    // MARK: Properties
    
    private let presenter: NAHomePresenterInterface
    private var skeletonTitleView: NASkeletonView?
    private var skeletonTableView: NASkeletonView?
    
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
    
    private lazy var categoryView = {
        let view = NACategoryView()
        return view
    }()
    
    private lazy var tableView = {
        let view = UITableView()
        return view
    }()

    // MARK: Initializer

    init(presenter: NAHomePresenterInterface) {
        self.presenter = presenter

        super.init()
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
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
}

extension NAHomeViewController: NAHomeViewModel {
    func setLoading(hasQuery: Bool) {
        titleLabel.isHidden = hasQuery ? false : true
        categoryView.isHidden = hasQuery ? false : true
        resultTitleLabel.isHidden = true
        tableView.isHidden = true
        
        let skeletonTitleView = NASkeletonView([.singleLine], height: 30)
        let skeletonTableView = NASkeletonView([.newsList], quantity: 4)
        
        view.addSubviews([skeletonTitleView, skeletonTableView], constraints: true)
        
        skeletonTitleView.nac
            .leading(16)
            .trailing(16)
        
        switch hasQuery {
        case true:
            skeletonTitleView.nac
                .top(categoryView.bottomAnchor, 32)
        default:
            skeletonTitleView.nac
                .top(view.safeAreaLayoutGuide.topAnchor, 24)
        }
        
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
        
        titleLabel.isHidden = false
        categoryView.isHidden = false
        resultTitleLabel.isHidden = false
        tableView.isHidden = false
    }
    
    func setHeaderTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setResultsTitle(_ text: String) {
        resultTitleLabel.text = text
    }
    
    func setNewsSuccess(newsList: Array<NewsItem>) {
        resultTitleLabel.text = I18n.Home.results.text
        self.newsList = newsList
    }
    
    func setNewsByQuerySuccess(newsList: Array<NewsItem>, querySearched: String) {
        resultTitleLabel.text = querySearched
        self.newsList = newsList
    }
    
    func setNewsFailed(error: String) {
        addAlert(title: I18n.APIError.title.text, message: error, cancelAction: I18n.APIError.ok.text)
    }
}

extension NAHomeViewController: UITableViewDataSource, UITableViewDelegate {

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

extension NAHomeViewController: NACategoryViewDelegate {
    func didTapCategoryBtn(_ category: QueryType) {
        switch category {
        case .topHeadlines:
            presenter.fetchNews()
        default:
            presenter.fetchNewsByQuery(category)
        }
    }
}

// MARK: ViewCode

extension NAHomeViewController: ViewCode {
    func buildHierarchy() {
        view.addSubviews([titleLabel, categoryView, resultTitleLabel, tableView], constraints: true)
    }
    
    func setupConstraints() {
        titleLabel.nac
            .top(view.safeAreaLayoutGuide.topAnchor)
            .leading(16)
            .trailing(16)
        
        categoryView.nac
            .top(titleLabel.bottomAnchor, 24)
            .leading()
            .trailing()
        
        resultTitleLabel.nac
            .top(categoryView.bottomAnchor, 12)
            .leading(16)
            .trailing(16)
        
        tableView.nac
            .top(resultTitleLabel.bottomAnchor, 12)
            .leading()
            .trailing()
            .bottom()
    }
    
    func applyAdditionalChanges() {
        categoryView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NANewsViewCell.self, forCellReuseIdentifier: NANewsViewCell.reuseIdentifier)
        tableView.backgroundColor = NAColor.body1.uiColor
    }
}

#Preview("NAHomeViewController") {
    NAHomeViewController(presenter: NAHomePresenter(coordinator: NAHomeCoordinator(), interactor: NAHomeInteractor()))
}
