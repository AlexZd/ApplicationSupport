//
//  AnyType.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/7/16.
//
//

// TODO: Find a way make it as Hashable
public protocol AnyType {
    var rawType: String { get }
}

extension AnyType {
    public var rawType: String {
        return "\(self)"
    }
}

public func == (lhs: AnyType?, rhs: AnyType?) -> Bool {
    if let left = lhs {
        if let right = rhs {
            if left.rawType != right.rawType { return false }
            switch left.rawType {
            case "Bool": return (left as! Bool) == (right as! Bool)
            case "Date": return (left as! Date).compare(right as! Date) == NSComparisonResult.OrderedSame
            case "Double": return (left as! Double) == (right as! Double)
            case "Float": return (left as! Float) == (right as! Float)
            case "Int": return (left as! Int) == (right as! Int)
            case "String": return (left as! String) == (right as! String)
            default: return false
            }
        }
        return false
    } else if let _ = rhs {
        return false
    }
    return true
}
