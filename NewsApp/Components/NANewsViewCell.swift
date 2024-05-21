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
        view.backgroundColor = NAColor.white.uiColor
        view.layer.cornerRadius = 8
        view.addElevation(elevation: .level1, cornerRadius: 8)
        return view
    }()
    
    private lazy var viewImage = {
        let view = UIImageView()
        view.backgroundColor = NAColor.black.uiColor
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var titleLabel = {
        let view = NALabel(.title2)
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
        
        viewImage.backgroundColor = NAColor.black.uiColor
        viewImage.image = news.image
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
        newsView.addSubviews([viewImage, contentStackView], constraints: true)
        contentView.addSubview(newsView, constraints: true)
    }
    
    func setupConstraints() {
        newsView.nac
            .top()
            .leading(16)
            .trailing(16)
            .bottom(24)
        
        viewImage.nac
            .top()
            .leading()
            .trailing()
            .height(160)
        
        contentStackView.nac
            .top(viewImage.bottomAnchor, 10)
            .leading(8)
            .trailing(8)
            .bottom(8)
    }
    
    func applyAdditionalChanges() {
        contentView.backgroundColor = NAColor.body1.uiColor
        selectionStyle = .none
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        newsView.addGestureRecognizer(gesture)
        
        let space = UIView()
        space.backgroundColor = NAColor.white.uiColor
        space.translatesAutoresizingMaskIntoConstraints = false
        viewImage.insertSubview(space, at: 0)
        space.nac
            .bottom(viewImage.bottomAnchor)
            .leading()
            .trailing()
            .height(8)
    }
}
