//
//  URL+Extension.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

extension URL: AnyType, DatabaseRepresentable {
    //MARK: - AnyType
    public var rawType: String { return "URL" }
    
    //MARK: - DatabaseRepresentable
    public var dbValue: AnyType { return self.absoluteString }
}
