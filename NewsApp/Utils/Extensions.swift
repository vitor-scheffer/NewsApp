//
//  Extensions.swift
//  NewsApp
//
//  Created by Vitor Boff on 15/05/24.
//

import Foundation
import UIKit

extension String {
    var localized: String { NSLocalizedString(self, bundle: .main, comment: "") }
    
    func localized(with arguments: String...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
    
    func isoFormatter() -> String {
        let formatter = ISO8601DateFormatter()
        
        guard let date = formatter.date(from: self) else {
            return ""
        }
        

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd 'de' MMMM 'de' yyyy"
        dateFormatter.locale = Locale(identifier: "pt_BR")
    
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
}

public extension UIViewController {
    func addAlert(title: String, message: String, cancelAction: String) {
        let controller = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: cancelAction, style: .cancel))
        
        self.present(controller, animated: true)
    }
}

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        addSubviews(subviews, constraints: true)
    }
    
    func addSubview(_ subview: UIView, constraints: Bool = true) {
        
        subview.translatesAutoresizingMaskIntoConstraints = !constraints
        addSubview(subview)
    }
    
    func addSubviews(_ subviews: [UIView], constraints: Bool = true) {
        
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = !constraints
            addSubview(subview)
        }
    }
    
    @discardableResult
    func top(
        _ constraint: NSLayoutYAxisAnchor? = nil,
        spacing: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        
        guard let superview = superview else { return nil }
        let constraint = constraint ?? superview.topAnchor
        
        let topAnchor = topAnchor.constraint(equalTo: constraint, constant: spacing)
        topAnchor.priority = priority
        topAnchor.isActive = isActive
        return topAnchor
    }
    
    @discardableResult
    func bottom(
        _ constraint: NSLayoutYAxisAnchor? = nil,
        spacing: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        
        guard let superview = superview else { return nil }
        let constraint = constraint ?? superview.bottomAnchor
        let bottomAnchor = bottomAnchor.constraint(equalTo: constraint, constant: -spacing)
        bottomAnchor.priority = priority
        bottomAnchor.isActive = isActive
        return bottomAnchor
    }
    
    @discardableResult
    func leading(
        _ constraint: NSLayoutXAxisAnchor? = nil,
        spacing: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        
        guard let superview = superview else { return nil }
        let constraint = constraint ?? superview.leadingAnchor
        let leadingAnchor = leadingAnchor.constraint(equalTo: constraint, constant: spacing)
        leadingAnchor.priority = priority
        leadingAnchor.isActive = isActive
        return leadingAnchor
    }
    
    @discardableResult
    func trailing(
        _ constraint: NSLayoutXAxisAnchor? = nil,
        spacing: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        
        guard let superview = superview else { return nil }
        let constraint = constraint ?? superview.trailingAnchor
        let trailingAnchor = trailingAnchor.constraint(equalTo: constraint, constant: -spacing)
        trailingAnchor.priority = priority
        trailingAnchor.isActive = isActive
        return trailingAnchor
    }
    
    @discardableResult
    func height(
        _ constraint: NSLayoutDimension? = nil,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        let constraint = constraint ?? superview.heightAnchor
        let heightAnchor = heightAnchor.constraint(equalTo: constraint)
        heightAnchor.priority = priority
        heightAnchor.isActive = isActive
        return heightAnchor
    }
    
    @discardableResult
    func height(
        _ size: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        let heightAnchor = heightAnchor.constraint(equalToConstant: size)
        heightAnchor.priority = priority
        heightAnchor.isActive = isActive
        return heightAnchor
    }
    
    @discardableResult
    func width(
        _ constraint: NSLayoutDimension? = nil,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        let constraint = constraint ?? superview.heightAnchor
        let widthAnchor = widthAnchor.constraint(equalTo: constraint)
        widthAnchor.priority = priority
        widthAnchor.isActive = isActive
        return widthAnchor
    }
    
    @discardableResult
    func width(
        _ size: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        let widthAnchor = widthAnchor.constraint(equalToConstant: size)
        widthAnchor.priority = priority
        widthAnchor.isActive = isActive
        return widthAnchor
    }
    
    @discardableResult
    func centerX(
        _ constraint: NSLayoutXAxisAnchor? = nil,
        spacing: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        
        guard let superview = superview else { return nil }
        let constraint = constraint ?? superview.centerXAnchor
        let centerXAnchor = centerXAnchor.constraint(equalTo: constraint, constant: spacing)
        centerXAnchor.priority = priority
        centerXAnchor.isActive = isActive
        return centerXAnchor
    }
    
    @discardableResult
    func centerY(
        _ constraint: NSLayoutYAxisAnchor? = nil,
        spacing: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        
        guard let superview = superview else { return nil }
        let constraint = constraint ?? superview.centerYAnchor
        let centerYAnchor = centerYAnchor.constraint(equalTo: constraint, constant: spacing)
        centerYAnchor.priority = priority
        centerYAnchor.isActive = isActive
        return centerYAnchor
    }
    
    func setSize(width: CGFloat, height: CGFloat) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height),
            widthAnchor.constraint(equalToConstant: width)
        ])
    }
}
