//
//  Metatype.swift
//  SVR
//
//  Created by Arkady Smirnov on 3/6/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

struct Metatype<T> : Hashable {
    
    static func == (lhs: Metatype, rhs: Metatype) -> Bool {
        return lhs.base == rhs.base
    }
    
    let base: T.Type
    
    init(_ base: T.Type) {
        self.base = base
    }
    
    var hashValue: Int {
        return ObjectIdentifier(base).hashValue
    }
}
