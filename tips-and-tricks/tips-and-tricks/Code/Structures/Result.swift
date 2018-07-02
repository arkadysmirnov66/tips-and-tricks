//
//  Result.swift
//  tips-and-tricks
//
//  Created by Arkady Smirnov on 7/3/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

public enum Result<Value> {
    
    case success(Value)
    case error(Error)
    
}

extension Result {
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .error:
            return false
        }
    }
    
    public var isError: Bool {
        return !isSuccess
    }
    
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .error:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .error(let error):
            return error
        case .success:
            return nil
        }
    }
    
    public func valueOrThrow() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .error(let error):
            throw error
        }
    }
    
    public func anyResult() -> Result<Any> {
        switch self {
        case .success(let value):
            return .success(value)
        case .error(let error):
            return .error(error)
        }
    }
   
}
