//
//  NALabel.swift
//  NewsApp
//
//  Created by Vitor Boff on 17/05/24.
//

import UIKit

public enum NAStyle {
    case title
    case title2
    case description
    case footnote
}

class NALabel: UILabel {
    
    public init(
        _ fontType: NAStyle = .description,
        textColor: UIColor = NAColor.black.uiColor,
        alignment: NSTextAlignment = .left,
        numberOfLines: Int = 0
    ) {
        super.init(frame: .zero)
        self.textAlignment = alignment
        self.textColor = textColor.withAlphaComponent(alpha)
        self.numberOfLines = numberOfLines
        setupFont(style: fontType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFont(style: NAStyle) {
        switch style {
        case .title:
            self.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        case .title2:
            self.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        case .description:
            self.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        case .footnote:
            self.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        }
    }
}
