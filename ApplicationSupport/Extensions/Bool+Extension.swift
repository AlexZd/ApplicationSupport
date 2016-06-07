//
//  Bool+Extension.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/7/16.
//
//

extension Bool: AnyType, DatabaseRepresentable {
    //MARK: - AnyType
    public var rawType: String { return "Bool" }
    
    //MARK: - DatabaseRepresentable
    public var dbValue: AnyType { return Int(self) }
}
