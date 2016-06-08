//
//  URL.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

import Foundation

class URL: NSURL, StringLiteralConvertible {
    typealias UnicodeScalarLiteralType = StringLiteralType
    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    required convenience init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(stringLiteral: value)
    }
    
    required convenience init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(stringLiteral: value)
    }
    
    required convenience init(stringLiteral value: StringLiteralType) {
        self.init(string: value, relativeToURL: nil)!
    }
    
    convenience init(string: String) {
        self.init(string: string, relativeToURL: nil)!
    }
}
