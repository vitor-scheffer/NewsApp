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
    let router = NARouter.shared

    // MARK: Methods

    func start() {
        let mainHomeTabbar = NATabBarController()
        tabBar = mainHomeTabbar
        let homeCoordinator = NAHomeCoordinator()
        let firstViewController = homeCoordinator.initWithNewNavigator()
        firstViewController.tabBarItem = UITabBarItem(title: I18n.TabBar.home.text,
                                                      image: UIImage(systemName: "house"),
                                                      tag: 0)
        
        let savedNavigation = UINavigationController()
        router.showSavedNews(navigator: savedNavigation)
        router.tabBarNavigator = mainHomeTabbar
        savedNavigation.tabBarItem = UITabBarItem(title: I18n.TabBar.saved.text,
                                                    image: UIImage(systemName: "bookmark"),
                                                    tag: 1)
        
        let tabBarViewController = [firstViewController, savedNavigation]
        
        tabBar?.viewControllers = tabBarViewController
        navigator?.pushViewController(mainHomeTabbar, animated: true)
        mainHomeTabbar.view.backgroundColor = NAColor.white.uiColor
        navigator?.setNavigationBarHidden(true, animated: true)
    }

    func exit() {
        navigator?.popToRootViewController(animated: true)
    }
}

