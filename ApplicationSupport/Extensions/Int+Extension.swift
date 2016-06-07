//
//  Int+Extension.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/7/16.
//
//

extension Int: AnyType, DatabaseRepresentable {
    //MARK: - AnyType
    public var rawType: String { return "Int" }
    
    //MARK: - DatabaseRepresentable
    public var dbValue: AnyType { return self }
}
