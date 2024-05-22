//
//  NARouter.swift
//  NewsApp
//
//  Created by Vitor Boff on 15/05/24.
//

import Foundation
import UIKit

public final class NARouter: NARouterProtocol {
    
    // MARK: Properties
    
    public static var shared = NARouter()
    
    public var navigator: UINavigationController?
    public var tabBarNavigator: UITabBarController?
    
    // MARK: Initializer

    private init() { }

    // MARK: Methods
    
    func showHome(navigator: UINavigationController?) {
        let coordinator = NATabBarCoordinator()
        coordinator.navigator = navigator
        coordinator.start()
    }
    
    func showNewsDetails(navigator: UINavigationController?, newsDetails: NewsItem) {
        let coordinator = NADetailsCoordinator(navigator: navigator, news: newsDetails)
        coordinator.start()
    }
    
    func showSavedNews(navigator: UINavigationController?) {
        let coordinator = NASavedNewsCoordinator()
        coordinator.navigator = navigator
        coordinator.start()
    }
}
