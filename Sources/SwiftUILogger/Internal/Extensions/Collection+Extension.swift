//
//  Collection+Extension.swift
//  
//
//  Created by Ahmed Shendy on 24/11/2022.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
