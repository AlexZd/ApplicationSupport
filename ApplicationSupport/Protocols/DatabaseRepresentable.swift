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

//import ObjectMapper

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

public extension DatabaseRepresentable {
    func equals(value: DatabaseRepresentable) -> Bool {
        if value.rawType == self.rawType {
            if value.dynamicType == String.self { return value as! String == self as! String }
            if value.dynamicType == Float.self { return value as! Float == self as! Float }
            if value.dynamicType == Double.self { return value as! Double == self as! Double }
            if value.dynamicType == Int.self { return value as! Int == self as! Int }
            if value.dynamicType == Date.self { return value as! Date == self as! Date }
            if value.dynamicType == Bool.self { return value as! Bool == self as! Bool }
        }
        return false
    }
}

extension String: DatabaseRepresentable {
    public var rawType: String { return "String" }
    public var dbValue: Any { return "'\(self)'" }
}
extension Int: DatabaseRepresentable {
    public var rawType: String { return "Int" }
}
extension Float: DatabaseRepresentable {
    public var rawType: String { return "Float" }
}
extension Bool: DatabaseRepresentable {
    public var rawType: String { return "Bool" }
    public var dbValue: Any { return Int(self) }
}
extension Double: DatabaseRepresentable {
    public var rawType: String { return "Double" }
}
extension Date: DatabaseRepresentable {
    public var rawType: String { return "Date" }
    public var dbValue: Any { return "'\(self)'" }
}
//extension Array where Element: Mappable {
//    public var dbValue: Any { return self.toJSON() }
//}