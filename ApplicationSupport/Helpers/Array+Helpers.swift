//
//  Array+Helpers.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

extension Sequence {
    public func find(predicate: (Self.Iterator.Element) throws -> Bool) rethrows -> Self.Iterator.Element? {
        for element in self {
            if try predicate(element) {
                return element
            }
        }
        return nil
    }
}

extension Array {
    public func contains<T>(_ obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}

@discardableResult
public func <<<T> (left: inout [T], right: [T]) -> [T] {
    left.append(contentsOf: right)
    return left
}

@discardableResult
public func <<<T> (left: inout [T], right: T) -> [T] {
    left.append(right)
    return left
}

@discardableResult
public func <<<T> (left: inout [T], right: [T]?) -> [T] {
    if let items = right {
        return left << items
    }
    return left
}

@discardableResult
public func <<<T> (left: inout [T], right: T?) -> [T] {
    if let item = right {
        return left << item
    }
    return left
}
