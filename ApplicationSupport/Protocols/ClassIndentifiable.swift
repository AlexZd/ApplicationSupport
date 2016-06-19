//
//  ClassIndentifiable.swift
//
//
//  Created by Alex Zdorovets on 6/19/16.
//
//

public protocol ClassIdentifiable {
    static var resourceName: String { get }
    static var modelName: String { get }
}

extension ClassIdentifiable {
    public static var resourceName: String {
        return self.modelName
    }
    
    public final static var modelName: String {
        var className = "\(self.dynamicType)"
        if let typeRange = className.rangeOfString(".Type") {
            className.replaceRange(typeRange, with: "")
        }
        return className
    }
}