//
//  NACategoryView.swift
//  NewsApp
//
//  Created by Vitor Boff on 24/05/24.
//

import UIKit

public final class NACategoryView: UIView {
    
    public var selected: QueryType? = .none {
        didSet {
            configureSelectedButton()
        }
    }
    
    public init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) { return nil }
    
    private func configureSelectedButton() {
        
    }
}
