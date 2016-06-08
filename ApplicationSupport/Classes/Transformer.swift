//
//  Transformer.swift
//
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

public typealias ForwardBlock = ((AnyType) -> Any?)
public typealias BacwardBlock = ((Any) -> AnyType?)

public struct Transformer {
    public var forward: ForwardBlock?
    public var backward: BacwardBlock?
    
    public init(forward: ForwardBlock?, backward: BacwardBlock? = nil) {
        self.forward = forward
        self.backward = backward
    }
    public init(backward: BacwardBlock?) {
        self.backward = backward
    }
}
