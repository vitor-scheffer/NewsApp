//
//  NAConstraints.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import UIKit

public extension UIView {
    var nac: NAConstraints { return NAConstraints(view: self) }
}

public class NAConstraints {
    private weak var view: UIView?
    
    public var parentView: UIView? {
        return view?.superview
    }
    
    init(view: UIView) {
        self.view = view
    }
    
    @discardableResult
    public func addSubView(_ view: UIView) -> NAConstraints {
        self.view?.addSubviews(view)
        return view.nac
    }
    
    @discardableResult
    public func addSubViews(_ views: UIView..., closure: ([NAConstraints]) -> Void) -> NAConstraints {
        self.view?.addSubviews(views)
        closure(views.map {$0.nac})
        return self
    }
    
    @discardableResult
    public func setAlpha(_ value: CGFloat) -> NAConstraints {
        view?.alpha = value
        return self
    }
    
    @discardableResult
    public func setCornerRadius(_ size: CGFloat) -> NAConstraints {
        view?.layer.cornerRadius = size
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(_ color: UIColor) -> NAConstraints {
        view?.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func top(_ spacing: CGFloat = 0) -> NAConstraints {
        view?.top(spacing: spacing, isActive: true, priority: .required)
        return self
    }
    
    @discardableResult
    public func top(_ constraint: NSLayoutYAxisAnchor, _ spacing: CGFloat = 0) -> NAConstraints {
        view?.top(constraint, spacing: spacing, isActive: true, priority: .required)
        return self
    }
    
    @discardableResult
    public func top(
        _ constraint: NSLayoutYAxisAnchor? = nil,
        spacing: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NAConstraints {
        view?.top(constraint, spacing: spacing, isActive: isActive, priority: priority)
        return self
    }
    
    @discardableResult
    public func bottom(_ spacing: CGFloat = 0) -> NAConstraints {
        view?.bottom(spacing: spacing, isActive: true, priority: .required)
        return self
    }
    
    @discardableResult
    public func bottom(_ constraint: NSLayoutYAxisAnchor, _ spacing: CGFloat = 0) -> NAConstraints {
        view?.bottom(constraint, spacing: spacing, isActive: true, priority: .required)
        return self
    }
    
    @discardableResult
    public func bottom(
        _ constraint: NSLayoutYAxisAnchor? = nil,
        spacing: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NAConstraints {
        view?.bottom(constraint, spacing: spacing, isActive: isActive, priority: priority)
        return self
    }
    
    @discardableResult
    public func leading(_ spacing: CGFloat = 0) -> NAConstraints {
        view?.leading(spacing: spacing, isActive: true, priority: .required)
        return self
    }
    
    @discardableResult
    public func leading(_ constraint: NSLayoutXAxisAnchor, _ spacing: CGFloat = 0) -> NAConstraints {
        view?.leading(constraint, spacing: spacing, isActive: true, priority: .required)
        return self
    }
    
    @discardableResult
    public func leadingEqualOrGreaterThan(_ constraint: NSLayoutXAxisAnchor, _ spacing: CGFloat = 0) -> NAConstraints {
        view?.leadingAnchor.constraint(greaterThanOrEqualTo: constraint,
                                       constant: spacing).isActive = true
        return self
    }
    
    @discardableResult
    public func leading(
        _ constraint: NSLayoutXAxisAnchor? = nil,
        spacing: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NAConstraints {
        view?.leading(
            constraint,
            spacing: spacing,
            isActive: isActive,
            priority: priority
        )
        return self
    }
    
    @discardableResult
    public func trailing(_ spacing: CGFloat = 0) -> NAConstraints {
        view?.trailing(spacing: spacing, isActive: true, priority: .required)
        return self
    }
    
    @discardableResult
    public func trailing(_ constraint: NSLayoutXAxisAnchor, _ spacing: CGFloat = 0) -> NAConstraints {
        view?.trailing(constraint, spacing: spacing, isActive: true, priority: .required)
        return self
    }
    
    @discardableResult
    public func trailing(
        _ constraint: NSLayoutXAxisAnchor? = nil,
        spacing: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NAConstraints {
        
        view?.trailing(
            constraint,
            spacing: spacing,
            isActive: isActive,
            priority: priority
        )
        return self
    }
    
    @discardableResult
    public func trailingEqualOrGreaterThan(_ constraint: NSLayoutXAxisAnchor, _ spacing: CGFloat = 0) -> NAConstraints {
        view?.trailingAnchor.constraint(greaterThanOrEqualTo: constraint,
                                       constant: -spacing).isActive = true
        return self
    }
    
    @discardableResult
    public func height(_ size: CGFloat = 0) -> NAConstraints {
        view?.height(size, isActive: true, priority: .required)
        return self
    }
    
    @discardableResult
    public func heightEqualOrGreaterThan(_ size: CGFloat = 0) -> NAConstraints {
        view?.heightAnchor.constraint(greaterThanOrEqualToConstant: size).isActive = true
        return self
    }
    
    @discardableResult
    public func height(
        _ size: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NAConstraints {
        view?.height(size, isActive: isActive, priority: priority)
        return self
    }
    
    @discardableResult
    public func height(_ constraint: NSLayoutDimension? = nil) -> NAConstraints {
        view?.height(constraint, isActive: true, priority: .required)
        return self
    }
    
    @discardableResult
    public func height(
        _ constraint: NSLayoutDimension? = nil,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NAConstraints {
        view?.height(constraint, isActive: isActive, priority: priority)
        return self
    }
    
    @discardableResult
    public func width(_ constraint: NSLayoutDimension? = nil) -> NAConstraints {
        view?.width(constraint, isActive: true, priority: .required)
        return self
    }
    
    @discardableResult
    public func width(
        _ constraint: NSLayoutDimension? = nil,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NAConstraints {
        view?.width(constraint, isActive: isActive, priority: priority)
        return self
    }
    
    @discardableResult
    public func width(_ size: CGFloat = 0) -> NAConstraints {
        view?.width(size, isActive: true, priority: .required)
        return self
    }
    
    @discardableResult
    public func width(
        _ size: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NAConstraints {
        view?.width(size, isActive: isActive, priority: priority)
        return self
    }
    
    @discardableResult
    public func centerX(
        _ constraint: NSLayoutXAxisAnchor? = nil,
        spacing: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NAConstraints {
        view?.centerX(constraint, spacing: spacing, isActive: isActive, priority: priority)
        return self
    }
    
    @discardableResult
    public func centerY(
        _ constraint: NSLayoutYAxisAnchor? = nil,
        spacing: CGFloat = 0,
        isActive: Bool = true,
        priority: UILayoutPriority = .required
    ) -> NAConstraints {
        view?.centerY(constraint, spacing: spacing, isActive: isActive, priority: priority)
        return self
    }
}

