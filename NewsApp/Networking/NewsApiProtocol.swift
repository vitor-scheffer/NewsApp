//
//  ApiProtocol.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import Foundation
import UIKit

public typealias HttpHeaders = [String: String]

public protocol NewsApiProtocol: AnyObject {
    func requestObject<T: Decodable>(endpoint: String,
                                     method: HttpMethod,
                                     headers: HttpHeaders?,
                                     type: T.Type,
                                     completion: @escaping CompletionCallback<T>)
    
    func requestImage(endpoint: String,
                      completion: @escaping CompletionCallbackImage<UIImage>)
}

public enum CompletionStatus<T> {
    case success(T)
    case failure(RequestError)
}

public enum CompletionImage<UIImage> {
    case success(UIImage)
    case failure(UIImage)
}

public enum RequestError: Error {
    case generic
    case decodingFailed
    case apiRefuseWithMsg(message: String)
    
    public var message: String {
        switch self {
        case .apiRefuseWithMsg(let apiMessage):
            return apiMessage
        default:
            return I18n.APIError.message.text
        }
    }
}

public enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public typealias CompletionCallback<T: Decodable> = (CompletionStatus<T>) -> Void
public typealias CompletionCallbackImage<UIImage> = (CompletionImage<UIImage>) -> Void
