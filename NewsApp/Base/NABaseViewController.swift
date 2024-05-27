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
        setupNavigationView()
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
        hidesBottomBarWhenPushed = false
        
        super.viewDidLoad()
    }
    
    public func setupLargeTitleAdjustLabel() {
        if #available(iOS 13.0, *) {
            navigationItem.setValue(true, forKey: "__largeTitleTwoLineMode")
        }
    }
    
    private func setupNavigationView() {
        self.navigationController?.navigationBar.tintColor = NAColor.black.uiColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
    }
}
