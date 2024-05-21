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
    
    private lazy var bannerView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var scrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private lazy var newsContentView = {
        let view = UIView()
        return view
    }()
    
    private lazy var publishedDateView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = NAColor.white.uiColor
        view.layer.cornerRadius = 32
        return view
    }()
    
    private lazy var authorLabel = {
        let view = NALabel(.footnote)
        return view
    }()
    
    private lazy var publishedDateLabel = {
        let view = NALabel(.footnote)
        return view
    }()
    
    private lazy var titleLabel = {
        let view = NALabel(.title2)
        return view
    }()
    
    private lazy var contentLabel = {
        let view = NALabel(.description)
        return view
    }()

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
        bannerView.image = newsDetails.image
        authorLabel.text = newsDetails.author
        publishedDateLabel.text = newsDetails.publishedAt
        titleLabel.text = newsDetails.title
        contentLabel.text = newsDetails.content
    }
    
    
}

// MARK: ViewCode

extension NADetailsViewController: ViewCode {
    func buildHierarchy() {
        view.addSubviews([bannerView, scrollView], constraints: true)
        bannerView.insertSubview(publishedDateView, at: .zero)
        publishedDateView.addSubviews([authorLabel, publishedDateLabel], constraints: true)
        scrollView.addSubview(newsContentView, constraints: true)
        newsContentView.addSubviews([
            titleLabel,
            contentLabel
        ], constraints: true)
    }
    
    func setupConstraints() {
        bannerView.nac
            .top(view.safeAreaLayoutGuide.topAnchor, 8)
            .leading()
            .trailing()
            .height(UIScreen.main.bounds.height/2)
        
        publishedDateView.nac
            .bottom(-32)
            .leading()
            .trailing()
            .height(60)
        
        authorLabel.nac
            .bottom(bannerView.bottomAnchor)
            .leading(20)
        
        publishedDateLabel.nac
            .bottom(bannerView.bottomAnchor)
            .trailing(20)
        
        scrollView.nac
            .top(bannerView.bottomAnchor)
            .leading(view.leadingAnchor)
            .trailing(view.trailingAnchor)
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        
        newsContentView.nac
            .top(scrollView.topAnchor)
            .leading(view.leadingAnchor, 16)
            .trailing(view.trailingAnchor, 16)
            .bottom(scrollView.bottomAnchor)
        
        titleLabel.nac
            .top(16)
            .leading()
            .trailing()
        
        contentLabel.nac
            .top(titleLabel.bottomAnchor, 12)
            .leading()
            .trailing()
            .bottom()
    }
    
    func applyAdditionalChanges() {
        view.backgroundColor = NAColor.white.uiColor
        view.clipsToBounds = true
    }
}
