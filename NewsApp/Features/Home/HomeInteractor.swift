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
                           type: NewsOutput.self) { [weak self] result in
            switch result {
            case .success(let result):
                self?.output?.fetchNewsSucceeded(result)
                
            case .failure(let result):
                self?.output?.fetchNewsFailed(result.message)
            }
        }
    }
}
