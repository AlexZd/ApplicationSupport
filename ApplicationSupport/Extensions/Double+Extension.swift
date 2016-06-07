//
//  Double+Extension.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/7/16.
//
//

extension Double: AnyType, DatabaseRepresentable {
    //MARK: - AnyType
    public var rawType: String { return "Double" }
    
    //MARK: - DatabaseRepresentable
    public var dbValue: AnyType { return self }
}
