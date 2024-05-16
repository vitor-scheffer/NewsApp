//
//  NewsOutput.swift
//  NewsApp
//
//  Created by Vitor Boff on 16/05/24.
//

import Foundation

public struct NewsOutput: Decodable {
    public let teste: String
    
    public init(teste: String) {
        self.teste = teste
    }
}
