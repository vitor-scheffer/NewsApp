//
//  NABaseSkeleton.swift
//  NewsApp
//
//  Created by Vitor Boff on 18/05/24.
//

import UIKit

class ODBaseSkeletonView: UIView {

    init(_ height: CGFloat? = nil, color: UIColor = NAColor.gray.uiColor) {
        super.init(frame: .zero)
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        layer.cornerRadius = 4
        backgroundColor = color
    }

    required init?(coder: NSCoder) { return nil }
}
