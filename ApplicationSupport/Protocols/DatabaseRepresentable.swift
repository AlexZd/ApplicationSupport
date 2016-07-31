//
//  DatabaseRepresentable.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/7/16.
//
//

// MARK: - Database represtable
// Because each database users different fields to represent data in db itself
// DatabaseRepresetable provides wrapping to give a garantee of safe data types

public protocol RawTypeRepresentable {
    // Returns string represetation of the type
    var rawType: String { get }
}

public extension RawTypeRepresentable {
    var rawType: String {
        return "\(self)"
    }
}

public protocol DatabaseRepresentable: RawTypeRepresentable {
    // Returns type safe value
    var dbValue: Any { get }
}

public extension DatabaseRepresentable {
    var dbValue: Any { return self }
}

public protocol AnyType: DatabaseRepresentable {}

public extension DatabaseRepresentable {
//    public var dbValue: Any { return self }
    func isEq(_ float: Float?) -> Bool { return false }
    func isEq(_ double: Double?) -> Bool { return false }
    func isEq(_ date: Date?) -> Bool { return false }
    func isEq(_ int: Int?) -> Bool { return false }
    func isEq(_ bool: Bool?) -> Bool { return false }
    func isEq(_ string: String?) -> Bool { return false }
}

//extension DatabaseRepresentable {
//    public func isEq(value: DatabaseRepresentable) -> Bool {
//        return false
//    }
//}

//protocol RealType: DatabaseRepresentable {}
//
//extension RealType {
//    
//}

// TOOD: dbValue and dbType should return the type basing on the Adapter types

//extension String: DatabaseRepresentable {
//    func isEq(_ string: String) -> Bool {
//        let v = self
//        return self == string
//    }
//}
//extension Int: DatabaseRepresentable {
//    func isEq(_ int: Int) -> Bool {
//        return self == int
//    }
//    func isEq(value: DatabaseRepresentable) -> Bool { return self == value as? Int }
//}
//extension Float: DatabaseRepresentable {
//    func isEq(value: DatabaseRepresentable) -> Bool { return self == value as? Float }
//}
//extension Bool: DatabaseRepresentable {
//    func isEq(value: DatabaseRepresentable) -> Bool { return self == value as? Bool }
//}
//extension Double: DatabaseRepresentable {
//    func isEq(value: DatabaseRepresentable) -> Bool { return self == value as? Double }
//}
//extension Date: DatabaseRepresentable {
//    func isEq(value: DatabaseRepresentable) -> Bool { return self == value as? Date }
//}

extension String: AnyType {
    public var rawType: String { return "String" }
    public var dbValue: Any { return "'\(self)'" }
}
extension Int: AnyType {
    public var rawType: String { return "Int" }
}
extension Float: AnyType {
    public var rawType: String { return "Float" }
}
extension Bool: AnyType {
    public var rawType: String { return "Bool" }
    public var dbValue: Any { return Int(self) }
}
extension Double: AnyType {
    public var rawType: String { return "Double" }
}
extension Date: AnyType {
    public var rawType: String { return "Date" }
    public var dbValue: Any { return "'\(self)'" }
}

//public func ==(lhs: AnyType?, rhs: AnyType?) -> Bool {
//    return lhs as? DatabaseRepresentable == rhs as? DatabaseRepresentable
//}
//
public func ==(lhs: DatabaseRepresentable?, rhs: DatabaseRepresentable?) -> Bool {
    if let left = lhs {
        if let right = rhs {
            if left.rawType != right.rawType { return false }
            switch left.rawType {
            case "String": return (left as! String) == (right as! String)
            case "Int": return (left as! Int) == (right as! Int)
            case "Float": return (left as! Float) == (right as! Float)
            case "Bool": return (left as! Bool) == (right as! Bool)
            case "Double": return (left as! Double) == (right as! Double)
            case "Date": return (left as! Date) == (right as! Date)
            default: return false
            }
        }
        return false
    } else if let right = rhs {
        return false
    }
    return true
}//
//public func ==(lhs: DatabaseRepresentable?, rhs: Float?) -> Bool {
//    if let left = lhs {
//        if let right = rhs {
//            if left.rawType != right.rawType { return false }
//            return left.isEq(right)
//        }
//        return false
//    } else if let right = rhs {
//        return false
//    }
//    return true
//}
//
//public func ==(lhs: DatabaseRepresentable?, rhs: Int?) -> Bool {
//    if let left = lhs {
//        if let right = rhs {
//            if left.rawType != right.rawType { return false }
//            return left.isEq(right)
//        }
//        return false
//    } else if let right = rhs {
//        return false
//    }
//    return true
//}
//
//public func ==(lhs: DatabaseRepresentable?, rhs: Double?) -> Bool {
//    if let left = lhs {
//        if let right = rhs {
//            if left.rawType != right.rawType { return false }
//            return left.isEq(right)
//        }
//        return false
//    } else if let right = rhs {
//        return false
//    }
//    return true
//}
//
//public func ==(lhs: DatabaseRepresentable?, rhs: Bool?) -> Bool {
//    if let left = lhs {
//        if let right = rhs {
//            if left.rawType != right.rawType { return false }
//            return left.isEq(right)
//        }
//        return false
//    } else if let right = rhs {
//        return false
//    }
//    return true
//}
//
//public func ==(lhs: DatabaseRepresentable?, rhs: String?) -> Bool {
//    if let left = lhs {
//        if let right = rhs {
//            if left.rawType != right.rawType { return false }
//            return left.isEq(right)
//        }
//        return false
//    } else if let right = rhs {
//        return false
//    }
//    return true
//}
//
//public func ==(lhs: DatabaseRepresentable?, rhs: Date?) -> Bool {
//    if let left = lhs {
//        if let right = rhs {
//            if left.rawType != right.rawType { return false }
//            return left.isEq(right)
//        }
//        return false
//    } else if let right = rhs {
//        return false
//    }
//    return true
//}