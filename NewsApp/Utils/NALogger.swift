//
//  NALogger.swift
//  NewsApp
//
//  Created by Vitor Boff on 19/05/24.
//

enum LogType {
    case success(url: String)
    case failed(url: String)
}

public final class NALogger {
    
    class func log(_ type: LogType) {
        switch type {
        case .success(url: let url):
            print(I18n.Logger.succeeded.text(with: url))
        case .failed(url: let url):
            print(I18n.Logger.failed.text(with: url))
        }
    }
}
