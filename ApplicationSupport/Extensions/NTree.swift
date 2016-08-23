//
//  Ntree.swift
//  Pods
//
//  Created by Vlad Gorbenko on 8/3/16.
//
//

import Foundation

public class Node<Key: Hashable, Value> {
    public var parent: Node<Key, Value>?
    public var value: Value?
    public var key: Key!
    public var nodes: [Node<Key, Value>] = []
    
    public init() {}
    public init(value: Value?) {
        self.value = value
    }
    public init(key: Key, value: Value?) {
        self.key = key
        self.value = value
    }
    
    public func set(key: Key, value: Value?) {
        self.key = key
        self.value = value
    }
    
    public func get(key: Key) -> Node<Key, Value>? {
        return self.nodes.filter({ $0.key == key }).first
    }
    
    public subscript(key: Key) -> Value? {
        get { return self.get(key)?.value }
        set {
            if let value = newValue {
                self.set(key, value: value)
            }
        }
    }
    
    public func hasNode(key: Key) -> Bool {
        return self.nodes.contains({ $0.key == key })
    }
    
    @warn_unused_result
    public func add(key: Key, value: Value?) -> Node<Key, Value> {
        let node = Node(key: key, value: value)
        node.parent = self
        self.nodes.append(node)
        return node
    }
    
    @warn_unused_result
    public func remore(key: Key) -> Node<Key, Value>? {
        if let index = self.nodes.indexOf({ $0.key == key }) {
            let node = self.nodes[index]
            self.nodes.removeAtIndex(index)
            return node
        }
        return nil
    }
}

public extension Node where Value: AnyObject {
    public func dictioanry() -> [Key: AnyObject] {
        if let value = self.value where self.nodes.isEmpty {
            return [self.key : value]
        }
        return [self.key: self.nodes.map({ $0.dictioanry() }).reduce([:], combine: +) as! AnyObject]
    }
}

public extension Dictionary where Key: StringLiteralConvertible, Value: AnyObject {
    func http() -> [String: AnyObject] {
        let tree = Node<String, AnyObject>(key: "root", value: nil)
        for (k, v) in self {
            let components = String(k).componentsSeparatedByString(".")
            var endNode: Node<String, AnyObject>! = tree
            for component in components {
                if endNode.hasNode(component) {
                    endNode = endNode.get(component)
                } else {
                    endNode = endNode.add(component, value: nil)
                }
            }
            endNode.value = v
        }
        return tree.dictioanry()["root"] as! [String: AnyObject]
    }
}