//
//  ViewCode.swift
//  NewsApp
//
//  Created by Vitor Boff on 15/05/24.
//

import Foundation

protocol ViewCode {
    func buildHierarchy()
    func setupConstraints()
    func applyAdditionalChanges()
}

extension ViewCode {
    func setupView() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
}
