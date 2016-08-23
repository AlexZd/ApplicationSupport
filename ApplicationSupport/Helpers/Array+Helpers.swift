//
//  Array+Helpers.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

extension SequenceType {
    public func find(@noescape predicate: (Self.Generator.Element) throws -> Bool) rethrows -> Self.Generator.Element? {
        for element in self {
            if try predicate(element) {
                return element
            }
        }
        return nil
    }
}

extension Array {
    public func contains<T where T : Equatable>(obj: T) -> Bool {
        return self.filter({$0 as? T == obj}).count > 0
    }
}

public func <<<T> (inout left: [T], right: [T]) -> [T] {
    left.appendContentsOf(right)
    return left
}

public func <<<T> (inout left: [T], right: T) -> [T] {
    left.append(right)
    return left
}

public func <<<T> (inout left: [T], right: [T]?) -> [T] {
    if let items = right {
        return left << items
    }
    return left
}

public func <<<T> (inout left: [T], right: T?) -> [T] {
    if let item = right {
        return left << item
    }
    return left
}