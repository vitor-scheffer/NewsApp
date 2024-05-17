//
//  Api.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import Foundation

struct ApiError: Decodable {
    let status: String
    let code: String
    let message: String
}

final public class NewsApi: NewsApiProtocol {
    
    public init() { }
    
    public static let shared = NewsApi()
        
        public func requestObject<T: Decodable>(
            endpoint: String,
            method: HttpMethod,
            headers: HttpHeaders?,
            type: T.Type,
            completion: @escaping CompletionCallback<T>) {
            
                guard let url = URL(string: NewsBaseUrl.baseUrl + endpoint + NewsBaseUrl.secretKey) else {
                completion(.failure(.generic))
                return
            }
            
            var request = URLRequest(url: url)
                request.httpMethod = method.rawValue
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                        completion(.failure(.generic))
                        return
                    }
                    
                    let statusCode = httpResponse.statusCode
                    
                    switch statusCode {
                    case 200...299:
                        let decoder = JSONDecoder()
                        do {
                            let decodedObject = try decoder.decode(type.self, from: data)
                            completion(.success(decodedObject))
                        } catch {
                            completion(.failure(.decodingFailed))
                        }
                    case 400...499:
                        let decoder = JSONDecoder()
                        do {
                            let decodedObject = try decoder.decode(ApiError.self, from: data)
                            completion(.failure(.apiRefuseWithMsg(message: decodedObject.message)))
                        } catch {
                            completion(.failure(.decodingFailed))
                        }
                    default:
                        completion(.failure(.generic))
                    }
                }
            
            task.resume()
        }
}
