//
//  UITableViewExtension.swift
//  NewsApp
//
//  Created by Vitor Boff on 27/05/24.
//

import Foundation
import UIKit

extension UITableView {
    func scrollToTopCell() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
