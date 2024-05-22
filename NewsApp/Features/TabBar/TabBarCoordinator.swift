//
//  TabBarController.swift
//  NewsApp
//
//  Created by Vitor Boff on 22/05/24.
//

import UIKit

final class NATabBarCoordinator: NATabBarCoordinatorInterface {

    // MARK: Properties
    var navigator: UINavigationController?
    var tabBar: NATabBarController?

    // MARK: Methods

    func start() {
        let mainHomeTabbar = NATabBarController()
        tabBar = mainHomeTabbar
        let homeCoordinator = NAHomeCoordinator()
        let firstViewController = homeCoordinator.initWithNewNavigator()
        firstViewController.tabBarItem = UITabBarItem(title: "Home".localized,
                                                      image: UIImage(systemName: "house"),
                                                      tag: 0)
        
        var tabBarViewController = [firstViewController]
        
        tabBar?.viewControllers = tabBarViewController
        navigator?.pushViewController(mainHomeTabbar, animated: true)
        mainHomeTabbar.view.backgroundColor = NAColor.white.uiColor
        navigator?.setNavigationBarHidden(true, animated: true)
    }

    func exit() {
        navigator?.popToRootViewController(animated: true)
    }
}

