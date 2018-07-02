//
//  DispatchQueue+Grades.swift
//  tips-and-tricks
//
//  Created by Arkady Smirnov on 7/3/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    func async<T>(_ completion: @escaping (T) -> Void, with result: T) {
        async {
            completion(result)
        }
    }
}
