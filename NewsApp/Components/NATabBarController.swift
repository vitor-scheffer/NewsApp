//
//  NATabBarController.swift
//  NewsApp
//
//  Created by Vitor Boff on 22/05/24.
//

import UIKit

public class NATabBarController: UITabBarController {
    let layerselect = CALayer()
    
    public override func viewDidLoad() {

        layerselect.backgroundColor = NAColor.black.cgColor
        tabBar.unselectedItemTintColor = NAColor.gray.uiColor
        tabBar.tintColor = NAColor.black.uiColor
        tabBar.barTintColor = NAColor.white.uiColor
        tabBar.isTranslucent = false
        tabBar.itemWidth = 24
        tabBar.itemPositioning = .fill
        guard let font = UIFont(name: "Inter-Regular", size: 10) else { return }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = NAColor.white.uiColor
            appearance.stackedLayoutAppearance.normal.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: NAColor.gray.uiColor]
            appearance.stackedLayoutAppearance.normal.iconColor = NAColor.gray.uiColor
            tabBar.standardAppearance = appearance
        }
        
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveSelectorView()
        tabBar.layer.addSublayer(layerselect)
    }

    public override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        moveSelectorView()
    }

    private func moveSelectorView() {
        if let view = tabBar.selectedItem?.value(forKey: "view") as? UIView {
            layerselect.frame = CGRect(x: view.frame.origin.x + view.frame.size.width/2 - 24,
                                       y: .zero,
                                       width: 48,
                                       height: 2)
        }
    }
    
    public override var selectedIndex: Int {
        didSet {
            if self.children.indices.contains(selectedIndex) {
                super.selectedIndex = selectedIndex
                moveSelectorView()
            }
        }
    }
}

