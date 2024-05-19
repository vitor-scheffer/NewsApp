//
//  NABaseViewController.swift
//  NewsApp
//
//  Created by Vitor Boff on 17/05/24.
//

import UIKit

open class NABaseViewController: UIViewController {
    
    public var expandedNavigationTitle = false
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { return nil }
    
    // MARK: Life Cycle
    
    open override func loadView() {
        super.loadView()
        view = UIView()
        
        view.backgroundColor = NAColor.body1.uiColor
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = expandedNavigationTitle ? .always : .never
    }
    
    open override func viewDidLoad() {
        hidesBottomBarWhenPushed = true
        
        super.viewDidLoad()
    }
    
    public func setupLargeTitleAdjustLabel() {
        if #available(iOS 13.0, *) {
            navigationItem.setValue(true, forKey: "__largeTitleTwoLineMode")
        }
    }
    
    private func setPrimaryNavigationStyle(style: NavigationStyle) {
        navigationController?.navigationBar.tintColor = NAColor.white.uiColor
        if #available(iOS 13.0, *) {
            if navigationController?.navigationBar.standardAppearance == nil {
                navigationController?.navigationBar.standardAppearance = UINavigationBarAppearance()
            }
            guard let appearance = navigationController?.navigationBar.standardAppearance else { return }
            
            switch style {
            case .primary: appearance.backgroundColor = UIColor.red
            case .dark: appearance.backgroundColor = UIColor.red
                
                appearance.titleTextAttributes =
                [
                    .foregroundColor: NAColor.white.uiColor,
                    .font: UIFont.systemFont(ofSize: 16)
                ]
                
                appearance.largeTitleTextAttributes =
                [
                    .foregroundColor: NAColor.white.uiColor,
                    .font: UIFont.systemFont(ofSize: 20)
                ]
                
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.compactAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
                navigationController?.navigationBar.isTranslucent = false
                
            }
        } else {
            
            switch style {
            case .primary: navigationController?.navigationBar.barTintColor = UIColor.blue
            case .dark: navigationController?.navigationBar.barTintColor = UIColor.blue
                
                navigationController?.navigationBar.titleTextAttributes =
                [
                    .foregroundColor: NAColor.white.uiColor,
                    .font: UIFont.systemFont(ofSize: 16)
                ]
                
                navigationController?.navigationBar.largeTitleTextAttributes =
                [
                    .foregroundColor: NAColor.white.uiColor,
                    .font:  UIFont.systemFont(ofSize: 20)
                ]
            }
        }
        
    }
    
    public enum NavigationStyle {
        case primary
        case dark
    }
}

