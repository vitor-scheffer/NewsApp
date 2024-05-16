//
//  ApiProtocol.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import Foundation

public typealias HttpHeaders = [String: String]

public protocol NewsApiProtocol: AnyObject {
    func requestObject<T: Decodable>(endpoint: String,
                                     method: HttpMethod,
                                     headers: HttpHeaders?,
                                     type: T.Type,
                                     completion: @escaping CompletionCallback<T>)
}

public enum CompletionStatus<T> {
    case success(T)
    case failure(RequestError)
    case apiRefuseWithMsg(message: String?)
}

public enum RequestError: Error {
    case generic
    case decodingFailed
}

public enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public typealias CompletionCallback<T: Decodable> = (CompletionStatus<T>) -> Void
