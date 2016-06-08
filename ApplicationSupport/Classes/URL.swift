//
//  URL.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

import Foundation

public class URL: NSURL, StringLiteralConvertible {
    public typealias UnicodeScalarLiteralType = StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    public required convenience init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(stringLiteral: value)
    }
    
    public required convenience init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(stringLiteral: value)
    }
    
    public required convenience init(stringLiteral value: StringLiteralType) {
        self.init(string: value, relativeToURL: nil)!
    }
    
    public convenience init(string: String) {
        self.init(string: string, relativeToURL: nil)!
    }
}
