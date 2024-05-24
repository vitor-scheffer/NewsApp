//
//  NAColo.swift
//  NewsApp
//
//  Created by Vitor Boff on 19/05/24.
//

import UIKit

public struct NAColor: Equatable {
    public let uiColor: UIColor
    public let cgColor: CGColor
    
    private init(uiColor: UIColor) {
        self.uiColor = uiColor
        self.cgColor = uiColor.cgColor
    }
    
    public static var black: NAColor {
        NAColor(uiColor: .black)
    }
    
    public static var white: NAColor {
        NAColor(uiColor: .white)
    }
    
    public static var body1: NAColor {
        NAColor(uiColor: UIColor(hex: "#E6E6E6"))
    }
    
    public static var gray: NAColor {
        NAColor(uiColor: UIColor(hex: "#a9a9a9"))
    }
}

extension CGColor {
    public static func NAColor(_ color: NAColor) -> CGColor {
        return color.cgColor
    }
}
