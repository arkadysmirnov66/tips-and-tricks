//
//  SynchronizedArray.swift
//  tips-and-tricks
//
//  Created by Arkady Smirnov on 7/3/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

private enum SynchronizedArrayConsts {
    static let dispatchQueueLabel: String = "com.e-legion.grades-ios.DataProvider.Utils.SynchronizedArray"
}

public class SynchronizedArray<Element> {
    
    private var array: Array<Element>
    private var queue: DispatchQueue
    
    public required init() {
        array = Array<Element>()
        queue = DispatchQueue( label: SynchronizedArrayConsts.dispatchQueueLabel, qos: Thread.current.qualityOfService.toDispatchQoS(), attributes: DispatchQueue.Attributes.concurrent)
    }
    
    public required init(arrayLiteral elements: Element...) {
        array = Array<Element>(elements)
        queue = DispatchQueue( label: SynchronizedArrayConsts.dispatchQueueLabel, qos: Thread.current.qualityOfService.toDispatchQoS(), attributes: DispatchQueue.Attributes.concurrent)
    }
    
    public required init(repeating repeatedValue: Element, count: Int) {
        array = Array<Element>(repeating: repeatedValue, count: count)
        queue = DispatchQueue( label: SynchronizedArrayConsts.dispatchQueueLabel, qos: Thread.current.qualityOfService.toDispatchQoS(), attributes: DispatchQueue.Attributes.concurrent)
    }
    
    public required init<S>(_ elements: S) where S: Sequence, Element == S.Element {
        array = Array<Element>(elements)
        queue = DispatchQueue( label: SynchronizedArrayConsts.dispatchQueueLabel, qos: Thread.current.qualityOfService.toDispatchQoS(), attributes: DispatchQueue.Attributes.concurrent)
    }
}

extension SynchronizedArray: MutableCollection {
    
    public func index(after i: Array<Element>.Index) -> Array<Element>.Index {
        return queue.sync {
            return self.array.index(after: i)
        }
    }
    
    public subscript(position: Index) -> Element {
        get {
            return queue.sync {
                return self.array[position]
            }
        }
        set(newValue) {
            queue.async(flags: .barrier) {
                self.array[position] = newValue
            }
        }
    }
    
    public var startIndex: Array<Element>.Index {
        return queue.sync {
            return self.array.startIndex
        }
    }
    
    public var endIndex: Array<Element>.Index {
        return queue.sync {
            return self.array.endIndex
        }
    }
    
    public typealias Index = Array<Element>.Index
    
    public typealias Iterator = IndexingIterator<SynchronizedArray<Element>>
    
    public func makeIterator() -> Iterator {
        return Iterator(_elements: self)
    }
    
}

extension SynchronizedArray: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Array<Element>.ArrayLiteralElement
}

extension SynchronizedArray: RandomAccessCollection {
    
}

extension SynchronizedArray: RangeReplaceableCollection {
    
    public func append(_ newElement: Element) {
        queue.async(flags: .barrier) {
            self.array.append(newElement)
        }
    }
    
    public func replaceSubrange<C>(_ subrange: Range<Index>, with newElements: C) where C: Collection, Element == C.Element {
        queue.async(flags: .barrier) {
            self.array.replaceSubrange(subrange, with: newElements)
        }
    }
    
    public func reserveCapacity(_ n: Int) {
        queue.async(flags: .barrier) {
            self.array.reserveCapacity(n)
        }
    }
    
    public func append<S>(contentsOf newElements: S) where S: Sequence, Element == S.Element {
        queue.async(flags: .barrier) {
            self.array.append(contentsOf: newElements)
        }
    }
    
    public func insert(_ newElement: Element, at i: Index) {
        queue.async(flags: .barrier) {
            self.array.insert(newElement, at: i)
        }
    }
    
    public func insert<S>(contentsOf newElements: S, at i: Index) where S: Collection, Element == S.Element {
        queue.async(flags: .barrier) {
            self.array.insert(contentsOf: newElements, at: i)
        }
    }
    
    public func remove(at i: Index) -> Element {
        return queue.sync(flags: .barrier) {
            return self.array.remove(at: i)
        }
    }
    
    public func removeFirst() -> Element {
        return queue.sync(flags: .barrier) {
            return self.array.removeFirst()
        }
    }
    
    public func removeFirst(_ n: Int) {
        queue.async(flags: .barrier) {
            self.array.removeFirst(n)
        }
    }
    
    public func removeAll(keepingCapacity keepCapacity: Bool) {
        queue.async(flags: .barrier) {
            self.array.removeAll(keepingCapacity: keepCapacity)
        }
    }
    
}
