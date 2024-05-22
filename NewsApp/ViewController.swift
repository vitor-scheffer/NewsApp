//
//  ViewController.swift
//  NewsApp
//
//  Created by Vitor Boff on 15/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    let router = NARouter.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    
        router.showHome(navigator: navigationController)
    }
}
