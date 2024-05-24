//
//  SavedNewsViewController.swift
//  NewsApp
//
//  Created by Vitor Boff on 22/05/24.
//

import UIKit

class NASavedNewsViewController: NABaseViewController {
    
    // MARK: Properties
    
    private let presenter: NASavedNewsPresenterInterface
    private var skeletonTitleView: NASkeletonView?
    private var skeletonTableView: NASkeletonView?
    private var emptyList: NALabel?
    
    private var newsList: [NewsItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var titleLabel = {
        let view = NALabel(.title)
        return view
    }()
    
    private var searchView = {
        let view = UISearchBar()
        view.barTintColor = NAColor.body1.uiColor
        view.layer.borderWidth = 1
        view.layer.borderColor = NAColor.body1.cgColor
        view.placeholder = I18n.TabBar.search.text
        view.searchTextField.backgroundColor = NAColor.white.uiColor
        view.searchTextField.addElevation(elevation: .level1)
        return view
    }()
    
    private lazy var tableView = {
        let view = UITableView()
        return view
    }()

    // MARK: Initializer

    init(presenter: NASavedNewsPresenterInterface) {
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

extension NASavedNewsViewController: NASavedNewsViewModel {
    func setLoading() {
        titleLabel.isHidden = true
        searchView.isHidden = true
        
        tableView.isHidden = true
        
        let skeletonTitleView = NASkeletonView([.singleLine], height: 30)
        let skeletonTableView = NASkeletonView([.newsList], quantity: 4)
        
        view.addSubviews([skeletonTitleView, skeletonTableView], constraints: true)
        
        skeletonTitleView.nac
            .top(view.safeAreaLayoutGuide.topAnchor, 24)
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
        emptyList?.removeFromSuperview()
        skeletonTitleView = nil
        skeletonTableView = nil
        emptyList = nil
        
        titleLabel.isHidden = false
        searchView.isHidden = false
        tableView.isHidden = false
    }
    
    func setHeaderTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setNewsSuccess(newsList: [NewsItem]) {
        self.newsList = newsList
    }
    
    func setNewsListEmpty() {
        tableView.isHidden = true
        
        emptyList = NALabel(.description)
        emptyList?.text = I18n.NewsSaved.empty.text
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

extension NASavedNewsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NANewsViewCell.reuseIdentifier,
                                                       for: indexPath) as? NANewsViewCell else {
            return UITableViewCell()
        }

        cell.delegate = self
        cell.setup(news: newsList[indexPath.row], indexPath: indexPath)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension NASavedNewsViewController: NANewsViewCellDelegate {
    func didTapView(row: Int) {
        presenter.newsSelected(newsList[row])
    }
}

// MARK: ViewCode

extension NASavedNewsViewController: ViewCode {
    func buildHierarchy() {
        view.addSubviews([titleLabel, searchView, tableView], constraints: true)
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
        
        tableView.nac
            .top(searchView.bottomAnchor, 24)
            .leading()
            .trailing()
            .bottom()
    }
    
    func applyAdditionalChanges() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NANewsViewCell.self, forCellReuseIdentifier: NANewsViewCell.reuseIdentifier)
        tableView.backgroundColor = NAColor.body1.uiColor
    }
}

#Preview("NASavedNewsViewController") {
    NASavedNewsViewController(presenter: NASavedNewsPresenter(coordinator: NASavedNewsCoordinator(), interactor: NASavedNewsInteractor()))
}
