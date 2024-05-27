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
        case saved = "NAsaved"
        case removed = "NAremoved"

        public var text: String {
            return NSLocalizedString(self.rawValue.localized, comment: "")
        }

        public func text(with complement: String...) -> String {
            String(format: NSLocalizedString(self.text, comment: "%@"), arguments: complement)
        }
    }
    
    public enum TabBar: String, I18nProtocol {
        case home = "NAtab.bar.home"
        case search = "NAtab.bar.search"
        case saved = "NAtab.bar.saved"

        public var text: String {
            return NSLocalizedString(self.rawValue.localized, comment: "")
        }

        public func text(with complement: String...) -> String {
            String(format: NSLocalizedString(self.text, comment: "%@"), arguments: complement)
        }
    }
    
    public enum APIError: String, I18nProtocol {
        case title = "NAerror.title"
        case message = "NAerror.message"
        case ok = "NAok.understood"

        public var text: String {
            return NSLocalizedString(self.rawValue.localized, comment: "")
        }

        public func text(with complement: String...) -> String {
            String(format: NSLocalizedString(self.text, comment: "%@"), arguments: complement)
        }
    }
    
    public enum Logger: String, I18nProtocol {
        case succeeded = "NAlogger.succeeded"
        case failed = "NAlogger.failed"

        public var text: String {
            return NSLocalizedString(self.rawValue.localized, comment: "")
        }

        public func text(with complement: String...) -> String {
            String(format: NSLocalizedString(self.text, comment: "%@"), arguments: complement)
        }
    }
    
    public enum Home: String, I18nProtocol {
        case author = "NAhome.author"
        case search = "NAhome.search.news"
        case results = "NAhome.results.title"
        case sports = "NAhome.results.sports"
        case entertainment = "NAhome.results.entertainment"
        case stocks = "NAhome.results.stocks"

        public var text: String {
            return NSLocalizedString(self.rawValue.localized, comment: "")
        }

        public func text(with complement: String...) -> String {
            String(format: NSLocalizedString(self.text, comment: "%@"), arguments: complement)
        }
    }
    
    public enum CoreDataError: String, I18nProtocol {
        case save = "NAerror.core.data.save"
        case delete = "NAerror.core.data.delete"
        case fetch = "NAerror.core.data.fetch"
        case fetchByID = "NAerror.core.data.fetch.by.id"
        
        public var text: String {
            return NSLocalizedString(self.rawValue.localized, comment: "")
        }
        
        public func text(with complement: String...) -> String {
            String(format: NSLocalizedString(self.text, comment: "%@"), arguments: complement)
        }
    }
    
    public enum Details: String, I18nProtocol {
        case saveSucceeded = "NAdetails.save.success"
        case deleteSucceeded = "NAdetails.delete.success"
        
        public var text: String {
            return NSLocalizedString(self.rawValue.localized, comment: "")
        }
        
        public func text(with complement: String...) -> String {
            String(format: NSLocalizedString(self.text, comment: "%@"), arguments: complement)
        }
    }
    
    public enum NewsSaved: String, I18nProtocol {
        case empty = "NAnews.saved.empty"
        case search = "NAnews.saved.search.news"
        
        public var text: String {
            return NSLocalizedString(self.rawValue.localized, comment: "")
        }
        
        public func text(with complement: String...) -> String {
            String(format: NSLocalizedString(self.text, comment: "%@"), arguments: complement)
        }
    }
    
    public enum Search: String, I18nProtocol {
        case message = "NAsearch.message"
        case empty = "NAsearch.empty"
        case resultsQuery = "NAsearch.results.query.title"
        
        public var text: String {
            return NSLocalizedString(self.rawValue.localized, comment: "")
        }
        
        public func text(with complement: String...) -> String {
            String(format: NSLocalizedString(self.text, comment: "%@"), arguments: complement)
        }
    }
}
