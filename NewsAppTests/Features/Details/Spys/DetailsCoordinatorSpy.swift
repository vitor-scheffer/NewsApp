//
//  DetailsCoordinatorSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

//
//  HomeCoordinatorSpy.swift
//  NewsAppTests
//
//  Created by Vitor Boff on 18/05/24.
//

import UIKit
@testable import NewsApp

final class NADetailsCoordinatorSpy: NADetailsCoordinatorInterface {
    var navigator: UINavigationController?
    
    var startCalled = false
    var navigateToHomeCalled = false
    
    func start() {
        self.startCalled = true
    }
    
    func navigateToHome() {
        self.navigateToHomeCalled = true
    }
}
