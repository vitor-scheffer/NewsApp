//
//  HomeInteractor.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import Foundation

final class NAHomeInteractor: NAHomeInteractorInput {
    
    // MARK: Properties
    
    var api: NewsApiProtocol?
    weak var output: NAHomeInteractorOutput?
    
    // MARK: Initializer
    
    init(api: NewsApiProtocol = NewsApi.shared, output: NAHomeInteractorOutput? = nil) {
        self.api = api
        self.output = output
    }
    
    // MARK: Methods
    
    func fetchNews() {
        api?.requestObject(endpoint: NAPaths.urlTopHeadlines,
                           method: .get,
                           headers: nil,
                           parameters: nil,
                           type: NewsOutput.self) { [weak self] result in
            switch result {
            case .success(let result):
                self?.output?.fetchNewsSucceeded(result, hasQuery: false)
                
            case .failure(let result):
                self?.output?.fetchNewsFailed(result.message)
            }
        }
    }
    
    func fetchNewsByQuery(_ input: NewsInput) {
        api?.requestObject(endpoint: NAPaths.urlEverything,
                           method: .get,
                           headers: nil,
                           parameters: input.toDictionary(),
                           type: NewsOutput.self) { [weak self] result in
            switch result {
            case .success(let result):
                if result.articles.isEmpty {
                    self?.output?.fetchNewsSucceededWithEmptyList()
                    return
                }
                self?.output?.fetchNewsSucceeded(result, hasQuery: true)
                
            case .failure(let result):
                self?.output?.fetchNewsFailed(result.message)
            }
        }
    }
}
