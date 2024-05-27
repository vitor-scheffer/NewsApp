//
//  StringExtension.swift
//  NewsApp
//
//  Created by Vitor Boff on 27/05/24.
//

import Foundation

extension String {
    var localized: String { NSLocalizedString(self, bundle: .main, comment: "") }
    
    func localized(with arguments: String...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
    
    func isoFormatter() -> String {
        let formatter = ISO8601DateFormatter()
        
        guard let date = formatter.date(from: self) else {
            return ""
        }
        

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd',' yyyy"
        dateFormatter.locale = Locale(identifier: "en-US")
    
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    func generateID() -> String {
        let source = UserDefaults.standard
        
        if let storageID = source.string(forKey: self) {
            return storageID
        }
        
        let generatedID = UUID().uuidString
        source.set(generatedID, forKey: self)
        
        return generatedID
    }
}
