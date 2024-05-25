//
//  SavedNewsInteractor.swift
//  NewsApp
//
//  Created by Vitor Boff on 22/05/24.
//

import Foundation

final class NASavedNewsInteractor: NASavedNewsInteractorInput {
    
    // MARK: Properties
    
    var api: CoreDataManagerProtocol?
    weak var output: NASavedNewsInteractorOutput?
    
    // MARK: Initializer
    
    init(api: CoreDataManagerProtocol = CoreDataManager.shared, output: NASavedNewsInteractorOutput? = nil) {
        self.api = api
        self.output = output
    }
    
    // MARK: Methods
    
    func fetchNews() {
        api?.fetchNews() { result in
            switch result {
            case .success(let newsDetails):
                if newsDetails.isEmpty {
                    self.output?.fetchNewsSucceededWithEmptyList()
                    return
                }
                self.output?.fetchNewsSucceeded(newsDetails)
            case .failure(let error):
                self.output?.fetchNewsFailed(error.message)
            }
        }
    }
}
