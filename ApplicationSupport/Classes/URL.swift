//
//  URL.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

import Foundation

open class URL: NSURL, ExpressibleByStringLiteral {
    public typealias UnicodeScalarLiteralType = StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    public required convenience init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(stringLiteral: value)
    }
    
    public required convenience init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(stringLiteral: value)
    }
    
    public required convenience init(stringLiteral value: StringLiteralType) {
        self.init(string: value, relativeTo: nil)!
    }
    
    public convenience init(string: String) {
        self.init(string: string, relativeTo: nil)!
    }
}
