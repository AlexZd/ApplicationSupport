//
//  Transformer.swift
//
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

public typealias ForwardBlock = ((value:AnyType) -> Any?)
public typealias BackwardBlock = ((value:Any) -> AnyType?)

public struct Transformer {
    
    public var forward: ForwardBlock?
    public var backward: BackwardBlock?
    
    public init(forward: ForwardBlock?, backward: BackwardBlock? = nil) {
        self.forward = forward
        self.backward = backward
    }
    
    public init(backward: BackwardBlock?) {
        self.backward = backward
    }
    
    public struct Defined {
        
        public static let URLTransformer = Transformer(forward: { (value) -> Any? in
            if let url = value as? String {
                return URL(string: url)
            }
            return nil
            }, backward: { (value) -> AnyType? in
                if let url = value as? URL {
                    return url.absoluteString
                }
                return nil
        })
        
    }
}
