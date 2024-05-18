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
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var viewImage = {
        let view = UIImageView()
        view.backgroundColor = .black
        view.contentMode = .scaleAspectFit
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
        
        viewImage.backgroundColor = news.image == UIImage(systemName: "photo") ? .white : .black
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
            .leading(24)
            .trailing(24)
            .bottom(24)
        
        viewImage.nac
            .top()
            .leading()
            .trailing()
            .height(160)
        
        contentStackView.nac
            .top(viewImage.bottomAnchor, 18)
            .leading(8)
            .trailing(8)
            .bottom(8)
    }
    
    func applyAdditionalChanges() {
        contentView.backgroundColor = UIColor(hex: "#f4f4f4")
        newsView.backgroundColor = .white
        selectionStyle = .none
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        newsView.addGestureRecognizer(gesture)
    }
    
    
}
