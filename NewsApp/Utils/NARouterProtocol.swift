//
//  NARouterProtocol.swift
//  NewsApp
//
//  Created by Vitor Boff on 15/05/24.
//

import Foundation
import UIKit

protocol NARouterProtocol: AnyObject {
    func showHome(navigator: UINavigationController?)
    func showNewsDetails(navigator: UINavigationController?)
}
