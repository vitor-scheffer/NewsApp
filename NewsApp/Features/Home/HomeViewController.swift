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
    
    private var newsList: [NewsItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var titleLabel = {
        let view = NALabel(.title)
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
    func setLoading() {
        titleLabel.isHidden = true
        tableView.isHidden = true
        
        let skeletonTitleView = NASkeletonView([.singleLine], color: UIColor(hex: "#a9a9a9", alpha: 1), height: 30)
        let skeletonTableView = NASkeletonView([.newsList], color: UIColor(hex: "#a9a9a9", alpha: 1), quantity: 4)
        
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
        skeletonTitleView = nil
        skeletonTableView = nil
        
        titleLabel.isHidden = false
        tableView.isHidden = false
    }
    
    func setHeaderTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setNewsSuccess(newsList: [NewsItem]) {
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

        cell.delegate = self
        cell.setup(news: newsList[indexPath.row], indexPath: indexPath)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension NAHomeViewController: NANewsViewCellDelegate {
    func didTapView(row: Int) {
        presenter.newsSelected(newsList[row])
    }
}


extension NAHomeViewController: ViewCode {
    func buildHierarchy() {
        view.addSubviews([titleLabel, tableView], constraints: true)
    }
    
    func setupConstraints() {
        titleLabel.nac
            .top(view.safeAreaLayoutGuide.topAnchor)
            .leading(16)
            .trailing(16)
        
        tableView.nac
            .top(titleLabel.bottomAnchor, 32)
            .leading()
            .trailing()
            .bottom()
    }
    
    func applyAdditionalChanges() {
        self.view.backgroundColor = UIColor(hex: "#f4f4f4")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NANewsViewCell.self, forCellReuseIdentifier: NANewsViewCell.reuseIdentifier)
        tableView.backgroundColor = UIColor(hex: "#f4f4f4")
    }
}
