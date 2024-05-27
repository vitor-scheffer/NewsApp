//
//  UIViewControllerExtension.swift
//  NewsApp
//
//  Created by Vitor Boff on 15/05/24.
//

import Foundation
import UIKit

public extension UIViewController {
    func addAlert(title: String, message: String, cancelAction: String) {
        let controller = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: cancelAction, style: .cancel))
        
        self.present(controller, animated: true)
    }
}

public enum NAElevation {
    case none
    case level1
    case level2
    case level3
    case level4
    
    var shadowOpacity: Float {
        switch self {
        case .none: return .zero
        case .level1: return 0.16
        case .level2: return 0.08
        case .level3: return 0.08
        case .level4: return 0.08
        }
    }
    
    var shadowOffset: CGFloat {
        switch self {
        case .none: return 0
        case .level1: return 4
        case .level2: return 4
        case .level3: return 8
        case .level4: return 16
        }
    }
    
    var shawdowRadius: CGFloat {
        switch self {
        case .none: return 0
        case .level1: return 8
        case .level2: return 16
        case .level3: return 24
        case .level4: return 32
        }
    }
}
