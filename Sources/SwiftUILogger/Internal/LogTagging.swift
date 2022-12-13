//
//  LogTagging.swift
//  
//
//  Created by Ahmed Shendy on 23/11/2022.
//

import Foundation

public protocol LogTagging: Hashable {
    var value: String { get }
}
