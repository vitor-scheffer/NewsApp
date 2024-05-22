//
//  TabBarProtocol.swift
//  NewsApp
//
//  Created by Vitor Boff on 22/05/24.
//

import UIKit

protocol NATabBarCoordinatorInterface: AnyObject {
    var navigator: UINavigationController? { get }
    var tabBar: NATabBarController? { get }
    func start()
}
