//
//  NASkeletonView.swift
//  NewsApp
//
//  Created by Vitor Boff on 18/05/24.
//

import UIKit

public enum NASkeletonType: Equatable {
    case newsList
    case singleLine
}

public final class NASkeletonView: UIView {
    private let stackView = UIStackView()
    private let color: UIColor
    private var types: [NASkeletonType] = []
    private let height: CGFloat
    private var quantity: Int
    
    public init(
        _ types: [NASkeletonType],
        color: UIColor = NAColor.gray.uiColor,
        height: CGFloat = 20,
        quantity: Int = 1
    ) {
        self.types = types
        self.color = color
        self.quantity = quantity
        self.height = height
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) { return nil }

    public override func didMoveToSuperview() {
        setupView()
        animate()
    }

    private func setupView() {
        stackView.axis = .vertical
        
        self.addSubviews(stackView)
        stackView.nac
            .top()
            .leading()
            .trailing()
            .bottom()
        
        for type in types {
            switch type {
            case .newsList: setupNewsList(quantity: quantity)
            case .singleLine: setupMultiLine(lines: 1, height)
            }
        }
    }
    
    private func setupNewsList(quantity: Int) {
        let innerStackView = UIStackView()
        innerStackView.spacing = 12
        innerStackView.axis = .vertical
        innerStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(innerStackView)
        
        for _ in 0..<quantity {
            let baseView = ODBaseSkeletonView(160, color: color)
            let lineOne = ODBaseSkeletonView(30, color: color)
            let lineTwo = ODBaseSkeletonView(16, color: color)
            let lineThree = ODBaseSkeletonView(12, color: color)
            let spacing = UIView()
            spacing.nac
                .height(24)
            innerStackView.addArrangedSubview(baseView)
            innerStackView.addArrangedSubview(lineOne)
            innerStackView.addArrangedSubview(lineTwo)
            innerStackView.addArrangedSubview(lineThree)
            innerStackView.addArrangedSubview(spacing)
        }
        
        innerStackView.nac
            .width(UIScreen.main.bounds.width - 16 - 16)
    }

    private func setupMultiLine(lines: Int, _ blockHeight: CGFloat) {
        
        let innerStackView = UIStackView()
        innerStackView.spacing = 8
        innerStackView.axis = .vertical
        innerStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(innerStackView)
        
        for _ in 0..<lines {
            let baseView = ODBaseSkeletonView(blockHeight, color: color)
            innerStackView.addArrangedSubview(baseView)
        }
        
        innerStackView.nac
            .width(UIScreen.main.bounds.width - 16 - 16)
    }

    private func animate() {
        guard let superview = superview else { return }
        superview.layoutIfNeeded()
        UIView.animate(
            withDuration: 0.9,
            delay: 0,
            options: [.autoreverse, .repeat, .curveEaseInOut]
        ) { [weak self] in
            self?.alpha = 0.1
            superview.layoutIfNeeded()
        }
    }
}

