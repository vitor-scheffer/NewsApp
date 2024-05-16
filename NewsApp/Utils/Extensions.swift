//
//  Extensions.swift
//  NewsApp
//
//  Created by Vitor Boff on 15/05/24.
//

import Foundation

extension String {
    var localized: String { NSLocalizedString(self, bundle: .main, comment: "") }
    
    func localized(with arguments: String...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}
