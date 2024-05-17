//
//  I18n.swift
//  NewsApp
//
//  Created by Vitor Boff on 15/05/24.
//

import Foundation

public protocol I18nProtocol {
    var text: String { get }

    func text(with complement: String...) -> String
}

public final class I18n {
    public enum General: String, I18nProtocol {
        case appName = "NAapp.name"
        case secretKey = "NAsecret.key"

        public var text: String {
            return NSLocalizedString(self.rawValue.localized, comment: "")
        }

        public func text(with complement: String...) -> String {
            String(format: NSLocalizedString(self.text, comment: "%@"), arguments: complement)
        }
    }

}

