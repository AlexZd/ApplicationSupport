//
//  Float+Extension.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/7/16.
//
//

extension Float: AnyType, DatabaseRepresentable {
    //MARK: - AnyType
    public var rawType: String { return "Float" }
    
    //MARK: - DatabaseRepresentable
    public var dbValue: AnyType { return self }
}
