//
//  SearchInteractor.swift
//  NewsApp
//
//  Created by Vitor Boff on 24/05/24.
//

import Foundation

final class NASearchInteractor: NASearchInteractorInput {
    
    // MARK: Properties
    
    var api: NewsApiProtocol?
    weak var output: NASearchInteractorOutput?
    
    // MARK: Initializer
    
    init(api: NewsApiProtocol = NewsApi.shared, output: NASearchInteractorOutput? = nil) {
        self.api = api
        self.output = output
    }
    
    // MARK: Methods
    
    func fetchNewsByQuery(_ input: NewsInput) {
        api?.requestObject(endpoint: NAPaths.urlEverything,
                           method: .get,
                           headers: nil,
                           parameters: input.toDictionary(),
                           type: NewsOutput.self) { [weak self] result in
            switch result {
            case .success(let result):
                if result.articles.isEmpty {
                    DispatchQueue.main.async {
                        self?.output?.fetchNewsSucceededWithEmptyList()
                    }
                    return
                }
                self?.output?.fetchNewsSucceeded(result)
                
            case .failure(let result):
                self?.output?.fetchNewsFailed(result.message)
            }
        }
    }
}
