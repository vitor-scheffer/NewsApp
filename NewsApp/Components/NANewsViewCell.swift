//
//  NANewsViewCell.swift
//  NewsApp
//
//  Created by Vitor Boff on 17/05/24.
//

import UIKit

protocol NANewsViewCellDelegate: AnyObject {
    func didTapView(row: Int)
}

final class NANewsViewCell: UITableViewCell {
    static var reuseIdentifier: String { String(describing: self) }
    
    private var indexPath: IndexPath?
    weak var delegate: NANewsViewCellDelegate?
    
    private lazy var newsView = {
        let view = UIView()
        return view
    }()
    
    private lazy var stackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 10
        return view
    }()
    
    private lazy var viewImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel = {
        let view = NALabel(.title)
        return view
    }()
    
    private lazy var descriptionLabel = {
        let view = NALabel(.description)
        return view
    }()
    
    private lazy var authorLabel = {
        let view = NALabel(.footnote)
        return view
    }()
    
    private lazy var contentStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 6
        return view
    }()

    func setup(news: NewsItem, indexPath: IndexPath) {
        setupView()
        
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        authorLabel.text = news.author
        
        self.indexPath = indexPath
    }
    
    @objc private func didTapView() {
        guard let indexPath = self.indexPath else { return }
        
        delegate?.didTapView(row: indexPath.row)
    }
}

extension NANewsViewCell: ViewCode {
    func buildHierarchy() {
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        contentStackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(viewImage)
        stackView.addArrangedSubview(contentStackView)
        newsView.addSubviews([stackView], constraints: true)
        contentView.addSubview(newsView, constraints: true)
    }
    
    func setupConstraints() {
        newsView.nac
            .top(contentView.topAnchor)
            .leading(24)
            .trailing(24)
            .bottom(contentView.bottomAnchor)
    }
    
    func applyAdditionalChanges() {
        contentView.backgroundColor = .white
        selectionStyle = .none
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        newsView.addGestureRecognizer(gesture)
    }
    
    
}
