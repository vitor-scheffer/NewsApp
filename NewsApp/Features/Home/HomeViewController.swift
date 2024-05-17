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
        print("HELLOOOOOOOOO")
    }
    
    

}

extension NAHomeViewController: NAHomeViewModel {
    func setHeaderTitle(_ text: String) {
        
    }
    
    func setNewsSuccess(remuneration: Double) {
        print("Success")
    }
    
    func setNewsFailed() {
        print("Success")
    }
}

extension NAHomeViewController: ViewCode {
    func buildHierarchy() {
        view.addSubview(containerView, constraints: true)
    }
    
    func setupConstraints() {
        containerView.nac
            .top(view.safeAreaLayoutGuide.topAnchor)
            .leading(view.safeAreaLayoutGuide.leadingAnchor)
            .trailing(view.safeAreaLayoutGuide.trailingAnchor)
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func applyAdditionalChanges() {
        containerView.backgroundColor = .magenta
    }
}
