//
//  AsyncOperation.swift
//  tips-and-tricks
//
//  Created by Arkady Smirnov on 7/3/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

public class AsyncOperation: Operation {
    public enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: KeyPath<AsyncOperation, Bool> {
            switch self {
            case .executing:
                return \AsyncOperation.isExecuting
            case .finished:
                return \AsyncOperation.isFinished
            case .ready:
                return \AsyncOperation.isReady
            }
            
        }
    }
    
    public var state: State = .ready {
        willSet {
            willChangeValue(for: newValue.keyPath)
            willChangeValue(for: state.keyPath)
        }
        didSet {
            didChangeValue(for: oldValue.keyPath)
            didChangeValue(for: state.keyPath)
        }
    }
    
    override public var isAsynchronous: Bool {
        return true
    }
    
    override public var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override public var isFinished: Bool {
        return state == .finished
    }
    
    override public var isExecuting: Bool {
        return state == .executing
    }
    
    override public func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        self.state = .executing
    }
    
    override public func cancel() {
        super.cancel()
        state = .finished
    }
}
