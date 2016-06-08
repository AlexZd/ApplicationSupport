//
//  Transformable.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

public protocol Transformable {
    static func transformers() -> Dictionary<String,Transformer>
}

extension Transformable {
    
    static func transformers() -> Dictionary<String,Transformer> {
        return [:]
    }
    
}
