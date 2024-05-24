//
//  NewsApiStub.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

import Foundation
@testable import NewsApp

final public class NewsApiStub: NewsApiProtocol {
    
    public var url: String?
    public var method: HttpMethod?
    
    public let status: CompletionStatus<Decodable>
    
    public init(status: CompletionStatus<Decodable>) {
        self.status = status
    }
    
    public func requestObject<T>(endpoint: String,
                                 method: HttpMethod, 
                                 headers: HttpHeaders?,
                                 parameters: [String: String]?,
                                 type: T.Type,
                                 completion: @escaping CompletionCallback<T>) where T : Decodable {
        
        self.url = NewsBaseUrl.baseUrl + endpoint + NewsBaseUrl.secretKey
        self.method = method
        
        switch status {
        case .success(let result):
            if let result = result as? T {
                completion(.success(result))
            } else {
                completion(.failure(RequestError.decodingFailed))
            }
        case .failure(let failure):
            completion(.failure(failure))
        }
    }
}
