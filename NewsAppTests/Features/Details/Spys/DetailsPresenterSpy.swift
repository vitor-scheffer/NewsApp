//
//  DetailsPresenterSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

import UIKit
@testable import NewsApp

final class NADetailsPresenterSpy: NADetailsPresenterInterface {
    var coordinator: NADetailsCoordinatorInterface = NADetailsCoordinatorSpy()
    var viewModel: NADetailsViewModel?
    
    var setViewModelCalled = false
    var viewWillAppearCalled = false
    var navigateToHomeCalled = false
    
    func setViewModel(_ viewModel: any NADetailsViewModel) {
        self.setViewModelCalled = true
        self.viewModel = viewModel
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.viewWillAppearCalled = true
    }
    
    func navigateToHome() {
        self.navigateToHomeCalled = true
    }
    
    func verifyNewsIsSaved(key: String) {
        
    }
    
    func bookmarkAction(_ sender: UIBarButtonItem) {
        
    }
}
