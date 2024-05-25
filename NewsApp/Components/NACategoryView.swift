//
//  NACategoryView.swift
//  NewsApp
//
//  Created by Vitor Boff on 24/05/24.
//

import UIKit

protocol NACategoryViewDelegate: AnyObject {
    func didTapCategoryBtn(_ category: QueryType)
}

public final class NACategoryView: UIView {
    weak var delegate: NACategoryViewDelegate?
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let categories: Array<String> = [
        I18n.Home.results.text,
        I18n.Home.sports.text,
        I18n.Home.entertainment.text,
        I18n.Home.stocks.text
    ]
    
    public var selected: QueryType? {
        didSet {
            configureSelectedButton()
        }
    }
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { return nil }
    
    private func configureSelectedButton() {
        var expectedTitle: String
        
        switch selected {
        case .sports:
            expectedTitle = I18n.Home.sports.text
        case .entertainment:
            expectedTitle = I18n.Home.entertainment.text
        case .stocks:
            expectedTitle = I18n.Home.stocks.text
        default:
            expectedTitle = I18n.Home.results.text
        }
        
        for case let button as UIButton in stackView.arrangedSubviews {
            guard let buttonText = button.titleLabel?.text else { return }
            
            if buttonText == expectedTitle {
                let attributeTitleBtn = NSMutableAttributedString(
                                    string: expectedTitle,
                                    attributes: [NSAttributedString.Key.foregroundColor : NAColor.white.uiColor,
                                                 NSAttributedString.Key.font : UIFont(name: "Inter-Regular", size: 12)!])
                button.setAttributedTitle(attributeTitleBtn, for: .normal)
                button.backgroundColor = NAColor.black.uiColor
            } else {
                let attributeTitleBtn = NSMutableAttributedString(
                    string: buttonText,
                                    attributes: [NSAttributedString.Key.foregroundColor : NAColor.black.uiColor,
                                                 NSAttributedString.Key.font : UIFont(name: "Inter-Regular", size: 12)!])
                button.setAttributedTitle(attributeTitleBtn, for: .normal)
                button.backgroundColor = NAColor.white.uiColor
            }
        }
    }
    
    @objc private func didTapBtn(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        
        switch title {
        case I18n.Home.sports.text:
            selected = .sports
        case I18n.Home.entertainment.text:
            selected = .entertainment
        case I18n.Home.stocks.text:
            selected = .stocks
        default:
            selected = .topHeadlines
        }
        
        if let selected { delegate?.didTapCategoryBtn(selected) }
    }
}

extension NACategoryView: ViewCode {
    func buildHierarchy() {
        addSubview(scrollView, constraints: true)
        scrollView.addSubview(stackView, constraints: true)
    }
    
    func setupConstraints() {
        scrollView.nac
            .top(8)
            .leading(16)
            .trailing(16)
            .bottom(8)
        
        stackView.nac
            .top()
            .leading()
            .trailing()
            .bottom()
            .height(scrollView.heightAnchor)
    }
    
    func applyAdditionalChanges() {
        backgroundColor = NAColor.body1.uiColor
        
        scrollView.showsHorizontalScrollIndicator = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        
        for category in categories {
            let categoryButton = UIButton()
            let attributeTitleBtn = NSMutableAttributedString(
                string: category,
                attributes: [NSAttributedString.Key.foregroundColor : NAColor.black.uiColor,
                             NSAttributedString.Key.font : UIFont(name: "Inter-Regular", size: 12)!]
            )
            
            categoryButton.backgroundColor = NAColor.white.uiColor
            categoryButton.layer.cornerRadius = 15
            categoryButton.setAttributedTitle(attributeTitleBtn, for: .normal)
            categoryButton.setTitleColor(NAColor.black.uiColor, for: .normal)
            categoryButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
            
            categoryButton.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
            stackView.addArrangedSubview(categoryButton)
        }
        
        selected = .topHeadlines
    }
}

#Preview("NACategoryView") {
    NACategoryView()
}
