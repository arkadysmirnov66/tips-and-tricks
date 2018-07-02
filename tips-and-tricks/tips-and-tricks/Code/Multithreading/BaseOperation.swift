//
//  BaseOperation.swift
//  tips-and-tricks
//
//  Created by Arkady Smirnov on 7/3/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

class BaseOperation<ResultType>: AsyncOperation {
    
    var result: Result<ResultType>? {
        didSet {
            guard !isCancelled else {
                return
            }
            
            if let result = self.result {
                if result.isError, let error = result.error {
                    self.errorHandler?(error)
                }
                if result.isSuccess, let value = result.value {
                    self.successHandler?(value)
                }
                self.state = .finished
            }
        }
    }
    
    var errorHandler: ((Error) -> Void)?
    var successHandler: ((ResultType) -> Void)?
    
}
