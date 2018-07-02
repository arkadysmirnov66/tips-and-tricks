//
//  QualityOfService+DispatchQoS.swift
//  tips-and-tricks
//
//  Created by Arkady Smirnov on 7/3/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

extension QualityOfService {
    public func toDispatchQoS() -> DispatchQoS {
        switch self {
        case .background:
            return .background
        case .userInitiated:
            return .userInitiated
        case .userInteractive:
            return .userInteractive
        case .utility:
            return .utility
        case .default:
            return .default
        }
    }
}
