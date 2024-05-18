//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Vitor Boff on 18/05/24.
//

import UIKit

class NADetailsViewController: NABaseViewController {
    
    // MARK: Properties
    
    private let presenter: NADetailsPresenterInterface
    
    private var newsList: [NewsItem] = []

    // MARK: Initializer

    init(presenter: NADetailsPresenterInterface) {
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

extension NADetailsViewController: NADetailsViewModel {
    func setupLayout(newsDetails: NewsItem) {
        print(newsDetails.content)
    }
    
    
}

extension NADetailsViewController: ViewCode {
    func buildHierarchy() {
    }
    
    func setupConstraints() {
    }
    
    func applyAdditionalChanges() {
    }
}
