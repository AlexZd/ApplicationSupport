//
//  Convertable.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

public protocol Convertable {
    
    func setAttributes(attributes: [String: AnyType?])
    
    func getAttributes() -> [String: AnyType?]
    
}

extension Convertable {
    
    func setAttributes(attributes: [String: AnyType?]) {
        
    }
    
    func getAttributes() -> [String: AnyType?] {
        return [:]
    }
}
