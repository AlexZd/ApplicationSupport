//
//  String+Extension.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/7/16.
//
//

// extension String: AnyType, DatabaseRepresentable {
//     //MARK: - AnyType
//     public var rawType: String { return "String" }
    
//     //MARK: - DatabaseRepresentable
//     public var dbValue: AnyType { return "'\(self)'" }
// }


public extension String {
    var untrim: String {
        var untrimmed = ""
        if !self.hasPrefix(" ") {
            untrimmed = " " + self
        }
        if !self.hasSuffix(" ") {
            untrimmed = self + " "
        }
        return untrimmed
    }
    
    public func wrap(char: String) -> String {
        return char + self + char
    }
    
    public var embrace: String {
        return "(" + self + ")"
    }
}