//
//  NARouter.swift
//  NewsApp
//
//  Created by Vitor Boff on 15/05/24.
//

import Foundation
import UIKit

public final class OARouter: NARouterProtocol {
    // MARK: Properties
    
    public static var shared = OARouter()
    
    public var navigator: UINavigationController?
    
    // MARK: Initializer

    private init() { }

    // MARK: Methods
    func showHome(navigator: UINavigationController?) {
        print("Hello World")
    }
}
