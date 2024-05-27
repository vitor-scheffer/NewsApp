//
//  NewsBaseUrl.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import Foundation

final public class NewsBaseUrl {
    public static var baseUrl: String {
        return "https://newsapi.org/v2"
    }
    
    static var secretKey: String {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else { return "" }
        return I18n.General.secretKey.text(with: apiKey)
    }
}
