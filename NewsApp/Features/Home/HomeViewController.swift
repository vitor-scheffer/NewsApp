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
    
    private lazy var containerView = {
        let view = UIView()
        return view
    }()
    
    private lazy var imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
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
        
    }
    
    func setNewsSuccess(news: NewsOutput) {
        print(news.totalResults)
    }
    
    func setNewsFailed(error: String) {
        addAlert(title: I18n.APIError.title.text, message: error, cancelAction: I18n.APIError.ok.text)
    }
}

extension NAHomeViewController: ViewCode {
    func buildHierarchy() {
        view.addSubviews([containerView, imageView], constraints: true)
    }
    
    func setupConstraints() {
        containerView.nac
            .top(view.safeAreaLayoutGuide.topAnchor)
            .leading(view.safeAreaLayoutGuide.leadingAnchor)
            .trailing(view.safeAreaLayoutGuide.trailingAnchor)
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        
        imageView.nac
            .centerX(containerView.centerXAnchor)
            .centerY(containerView.centerYAnchor)
            .width(containerView.widthAnchor)
    }
    
    func applyAdditionalChanges() {
        containerView.backgroundColor = .magenta
    }
}
