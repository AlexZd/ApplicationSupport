//
//  String+Extension.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/7/16.
//
//

extension String: AnyType, DatabaseRepresentable {
    //MARK: - AnyType
    public var rawType: String { return "String" }
    
    //MARK: - DatabaseRepresentable
    public var dbValue: AnyType { return "'\(self)'" }
}
