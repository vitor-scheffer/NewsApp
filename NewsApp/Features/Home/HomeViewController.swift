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
        return .lightContent
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
        presenter.navigateToDetails(newsList[row])
    }
}


extension NAHomeViewController: ViewCode {
    func buildHierarchy() {
        view.addSubviews([titleLabel, tableView], constraints: true)
    }
    
    func setupConstraints() {
        titleLabel.nac
            .top(view.safeAreaLayoutGuide.topAnchor)
            .leading(24)
            .trailing(24)
        
        tableView.nac
            .top(titleLabel.bottomAnchor)
            .leading()
            .trailing()
            .bottom()
    }
    
    func applyAdditionalChanges() {
        self.view.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 255)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NANewsViewCell.self, forCellReuseIdentifier: NANewsViewCell.reuseIdentifier)
    }
}
