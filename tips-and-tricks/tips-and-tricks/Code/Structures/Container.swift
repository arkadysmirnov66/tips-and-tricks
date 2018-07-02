//
//  Container.swift
//  SVR
//
//  Created by Arkady Smirnov on 3/2/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

public class Container {
    
    private var container: Dictionary<AnyHashable, Any>
    
    public init() {
        container = Dictionary<AnyHashable, Any>()
    }
    
    public func register<Type> (_ type: Type.Type, closure: @escaping () -> Type) {
        self.container[Metatype(type)] = closure
    }
    
    public func resolve<T>(_ type: T.Type) -> T? {
        return (container[Metatype(T.self)] as? (() -> T))?()
    }

}
