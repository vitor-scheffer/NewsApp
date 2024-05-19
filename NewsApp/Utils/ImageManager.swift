//
//  ImageManager.swift
//  NewsApp
//
//  Created by Vitor Boff on 17/05/24.
//

import Foundation
import UIKit

final public class ImageManager {
    
    let genericImage = UIImage(named: "randomNews")
    
    init() { }
    
    func fetchImage(url: String?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url, let urlObject = URL(string: url) else {
            completion(genericImage)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlObject) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        task.resume()
    }
}


