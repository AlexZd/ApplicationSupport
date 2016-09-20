//
//  Ntree.swift
//  Pods
//
//  Created by Vlad Gorbenko on 8/3/16.
//
//

import Foundation

open class Node<Key: Hashable, Value> {
    open var parent: Node<Key, Value>?
    open var value: Value?
    open var key: Key!
    open var nodes: [Node<Key, Value>] = []
    
    public init() {}
    public init(value: Value?) {
        self.value = value
    }
    public init(key: Key, value: Value?) {
        self.key = key
        self.value = value
    }
    
    open func set(_ key: Key, value: Value?) {
        self.key = key
        self.value = value
    }
    
    open func get(_ key: Key) -> Node<Key, Value>? {
        return self.nodes.filter({ $0.key == key }).first
    }
    
    open subscript(key: Key) -> Value? {
        get { return self.get(key)?.value }
        set {
            if let value = newValue {
                self.set(key, value: value)
            }
        }
    }
    
    open func hasNode(_ key: Key) -> Bool {
        return self.nodes.contains(where: { $0.key == key })
    }
    
    
    open func add(_ key: Key, value: Value?) -> Node<Key, Value> {
        let node = Node(key: key, value: value)
        node.parent = self
        self.nodes.append(node)
        return node
    }
    
    
    open func remore(_ key: Key) -> Node<Key, Value>? {
        if let index = self.nodes.index(where: { $0.key == key }) {
            let node = self.nodes[index]
            self.nodes.remove(at: index)
            return node
        }
        return nil
    }
}

public extension Node where Value: AnyObject {
    public func dictioanry() -> [Key: AnyObject] {
        if let value = self.value , self.nodes.isEmpty {
            return [self.key : value]
        }
        return [self.key: self.nodes.map({ $0.dictioanry() }).reduce([:], +) as AnyObject]
    }
}

public extension Dictionary where Key: ExpressibleByStringLiteral, Value: AnyObject {
    func http() -> [String: AnyObject] {
        let tree = Node<String, AnyObject>(key: "root", value: nil)
        for (k, v) in self {
            let components = String(describing: k).components(separatedBy: ".")
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
