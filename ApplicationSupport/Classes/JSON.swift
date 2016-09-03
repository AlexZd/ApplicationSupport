//
//  JSON.swift
//  Pods
//
//  Created by Vlad Gorbenko on 8/25/16.
//
//

import Foundation

//
//  StringUtils.swift
//  JsonSerializer
//
//  Created by Fuji Goro on 2014/09/15.
//  Copyright (c) 2014 Fuji Goro. All rights reserved.
//

let unescapeMapping: [UnicodeScalar: UnicodeScalar] = [
    "t": "\t",
    "r": "\r",
    "n": "\n",
]

let escapeMapping: [Character : String] = [
    "\r": "\\r",
    "\n": "\\n",
    "\t": "\\t",
    "\\": "\\\\",
    "\"": "\\\"",
    
    "\u{2028}": "\\u2028", // LINE SEPARATOR
    "\u{2029}": "\\u2029", // PARAGRAPH SEPARATOR
    
    // XXX: countElements("\r\n") is 1 in Swift 1.0
    "\r\n": "\\r\\n",
]

let hexMapping: [UnicodeScalar : UInt32] = [
    "0": 0x0,
    "1": 0x1,
    "2": 0x2,
    "3": 0x3,
    "4": 0x4,
    "5": 0x5,
    "6": 0x6,
    "7": 0x7,
    "8": 0x8,
    "9": 0x9,
    "a": 0xA, "A": 0xA,
    "b": 0xB, "B": 0xB,
    "c": 0xC, "C": 0xC,
    "d": 0xD, "D": 0xD,
    "e": 0xE, "E": 0xE,
    "f": 0xF, "F": 0xF,
]

let digitMapping: [UnicodeScalar:Int] = [
    "0": 0,
    "1": 1,
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6,
    "7": 7,
    "8": 8,
    "9": 9,
]

extension SequenceType where Generator.Element == String {
    /// Interpose the `separator` between elements of `self`, then concatenate
    /// the result.  For example:
    ///
    ///     ["foo", "bar", "baz"].joinWithSeparator("-|-") // "foo-|-bar-|-baz"
    @warn_unused_result
    public func joined(separator: String) -> String {
        return self.joinWithSeparator(separator)
    }
}

public extension Dictionary where Key: StringLiteralConvertible {
    func json(pretty: Bool = false) -> String {
        var jsonDictionary: [String: Json] = [:]
        for (k, v) in self {
            if let value = v as? Bool { jsonDictionary["\(k)"] = Json(value) } else
            if let value = v as? Int { jsonDictionary["\(k)"] = Json(integerLiteral: value) } else
            if let value = v as? Double { jsonDictionary["\(k)"] = Json(value) } else
            if let value = v as? Float { jsonDictionary["\(k)"] = Json(Double(value)) } else
            if let value = v as? String { jsonDictionary["\(k)"] = Json(value) }
//            if let value = v as? [String: Any] { jsonDictionary["\(k)"] = Json(value) }
        }
        let json: Json = .ObjectValue(jsonDictionary)
        return json.serialize(DefaultJsonSerializer())
    }
}

extension String {
    
    
    public var escapedJsonString: String {
        let mapped = characters.map { escapeMapping[$0] ?? String($0) }.joined("")
        return "\"" + mapped + "\""
    }
}

public func escapeAsJsonString(_ source : String) -> String {
    return source.escapedJsonString
}

func digitToInt(_ b: UInt8) -> Int? {
    return digitMapping[UnicodeScalar(b)]
}

func hexToDigit(_ b: UInt8) -> UInt32? {
    return hexMapping[UnicodeScalar(b)]
}



public enum Json: CustomStringConvertible, CustomDebugStringConvertible, Equatable {
    
    case NullValue
    case BooleanValue(Bool)
    case NumberValue(Double)
    case StringValue(String)
    case ArrayValue([Json])
    case ObjectValue([String:Json])
    
    // MARK: Initialization
    
    public init(_ value: Bool) {
        self = .BooleanValue(value)
    }
    
    public init(_ value: Double) {
        self = .NumberValue(value)
    }
    
    public init(_ value: String) {
        self = .StringValue(value)
    }
    
    public init(_ value: [Json]) {
        self = .ArrayValue(value)
    }
    
    public init(_ value: [String : Json]) {
        self = .ObjectValue(value)
    }
    
    // MARK: From
    
    public static func from(_ value: Bool) -> Json {
        return .BooleanValue(value)
    }
    
    public static func from(_ value: Double) -> Json {
        return .NumberValue(value)
    }
    
    public static func from(_ value: String) -> Json {
        return .StringValue(value)
    }
    
    public static func from(_ value: [Json]) -> Json {
        return .ArrayValue(value)
    }
    
    public static func from(_ value: [String : Json]) -> Json {
        return .ObjectValue(value)
    }
}

// MARK: Serialization

extension Json {
//    public static func deserialize(_ source: String) throws -> Json {
//        return try JsonDeserializer(source.utf8).deserialize()
//    }
//    
//    public static func deserialize(_ source: [UInt8]) throws -> Json {
//        return try JsonDeserializer(source).deserialize()
//    }
//    
//    public static func deserialize<ByteSequence: Collection where ByteSequence.Iterator.Element == UInt8>(_ sequence: ByteSequence) throws -> Json {
//        return try JsonDeserializer(sequence).deserialize()
//    }
}

extension Json {
    public enum SerializationStyle {
        case Default
        case PrettyPrint
        
        private var serializer: JsonSerializer.Type {
            switch self {
            case .Default:
                return DefaultJsonSerializer.self
            case .PrettyPrint:
                return PrettyJsonSerializer.self
            }
        }
    }
    
    public func serialize(_ style: SerializationStyle = .Default) -> String {
        return style.serializer.init().serialize(self)
    }
}

// MARK: Convenience

extension Json {
    public var isNull: Bool {
        guard case .NullValue = self else { return false }
        return true
    }
    
    public var boolValue: Bool? {
        if case let .BooleanValue(bool) = self {
            return bool
        } else if let integer = intValue where integer == 1 || integer == 0 {
            // When converting from foundation type `[String : AnyObject]`, something that I see as important,
            // it's not possible to distinguish between 'bool', 'double', and 'int'.
            // Because of this, if we have an integer that is 0 or 1, and a user is requesting a boolean val,
            // it's fairly likely this is their desired result.
            return integer == 1
        } else {
            return nil
        }
    }
    
    public var floatValue: Float? {
        guard let double = doubleValue else { return nil }
        return Float(double)
    }
    
    public var doubleValue: Double? {
        guard case let .NumberValue(double) = self else {
            return nil
        }
        
        return double
    }
    
    public var intValue: Int? {
        guard case let .NumberValue(double) = self where double % 1 == 0 else {
            return nil
        }
        
        return Int(double)
    }
    
    public var uintValue: UInt? {
        guard let intValue = intValue else { return nil }
        return UInt(intValue)
    }
    
    public var stringValue: String? {
        guard case let .StringValue(string) = self else {
            return nil
        }
        
        return string
    }
    
    public var arrayValue: [Json]? {
        guard case let .ArrayValue(array) = self else { return nil }
        return array
    }
    
    public var objectValue: [String : Json]? {
        guard case let .ObjectValue(object) = self else { return nil }
        return object
    }
}

extension Json {
    public subscript(index: Int) -> Json? {
        assert(index >= 0)
        guard let array = arrayValue where index < array.count else { return nil }
        return array[index]
    }
    
    public subscript(key: String) -> Json? {
        get {
            guard let dict = objectValue else { return nil }
            return dict[key]
        }
        set {
            guard let object = objectValue else { fatalError("Unable to set string subscript on non-object type!") }
            var mutableObject = object
            mutableObject[key] = newValue
            self = .from(mutableObject)
        }
    }
}

extension Json {
    public var description: String {
        return serialize(DefaultJsonSerializer())
    }
    
    public var debugDescription: String {
        return serialize(PrettyJsonSerializer())
    }
}

extension Json {
    public func serialize(_ serializer: JsonSerializer) -> String {
        return serializer.serialize(self)
    }
}


public func ==(lhs: Json, rhs: Json) -> Bool {
    switch lhs {
    case .NullValue:
        return rhs.isNull
    case .BooleanValue(let lhsValue):
        guard let rhsValue = rhs.boolValue else { return false }
        return lhsValue == rhsValue
    case .StringValue(let lhsValue):
        guard let rhsValue = rhs.stringValue else { return false }
        return lhsValue == rhsValue
    case .NumberValue(let lhsValue):
        guard let rhsValue = rhs.doubleValue else { return false }
        return lhsValue == rhsValue
    case .ArrayValue(let lhsValue):
        guard let rhsValue = rhs.arrayValue else { return false }
        return lhsValue == rhsValue
    case .ObjectValue(let lhsValue):
        guard let rhsValue = rhs.objectValue else { return false }
        return lhsValue == rhsValue
    }
}

// MARK: Literal Convertibles

extension Json: NilLiteralConvertible {
    public init(nilLiteral value: Void) {
        self = .NullValue
    }
}

extension Json: BooleanLiteralConvertible {
    public init(booleanLiteral value: BooleanLiteralType) {
        self = .BooleanValue(value)
    }
}

extension Json: IntegerLiteralConvertible {
    public init(integerLiteral value: IntegerLiteralType) {
        self = .NumberValue(Double(value))
    }
}

extension Json: FloatLiteralConvertible {
    public init(floatLiteral value: FloatLiteralType) {
        self = .NumberValue(Double(value))
    }
}

extension Json: StringLiteralConvertible {
    public typealias UnicodeScalarLiteralType = String
    public typealias ExtendedGraphemeClusterLiteralType = String
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = .StringValue(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterType) {
        self = .StringValue(value)
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self = .StringValue(value)
    }
}

extension Json: ArrayLiteralConvertible {
    public init(arrayLiteral elements: Json...) {
        self = .ArrayValue(elements)
    }
}

extension Json: DictionaryLiteralConvertible {
    public init(dictionaryLiteral elements: (String, Json)...) {
        var object = [String : Json](minimumCapacity: elements.count)
        elements.forEach { key, value in
            object[key] = value
        }
        self = .ObjectValue(object)
    }
}

public protocol JsonSerializer {
    init()
    func serialize(_: Json) -> String
}

internal class DefaultJsonSerializer: JsonSerializer {
    
    required init() {}
    
    internal func serialize(_ json: Json) -> String {
        switch json {
        case .NullValue:
            return "null"
        case .BooleanValue(let b):
            return b ? "true" : "false"
        case .NumberValue(let n):
            return serializeNumber(n)
        case .StringValue(let s):
            return escapeAsJsonString(s)
        case .ArrayValue(let a):
            return serializeArray(a)
        case .ObjectValue(let o):
            return serializeObject(o)
        }
    }
    
    func serializeNumber(_ n: Double) -> String {
        if n == Double(Int64(n)) {
            return Int64(n).description
        } else {
            return n.description
        }
    }
    
    func serializeArray(_ array: [Json]) -> String {
        var string = "["
        string += array.map { $0.serialize(self) }.joinWithSeparator(",")
        return string + "]"
    }
    
    func serializeObject(_ object: [String : Json]) -> String {
        var string = "{"
        string += object.map { "\(escapeAsJsonString($0)): \($1.serialize(self))" }.joinWithSeparator(",")
        return string + "}"
    }
    
}

internal class PrettyJsonSerializer: DefaultJsonSerializer {
    private var indentLevel = 0
    
    required init() {
        super.init()
    }
    
    override internal func serializeArray(_ array: [Json]) -> String {
        indentLevel += 1
        defer {
            indentLevel -= 1
        }
        
        let indentString = indent()
        
        var string = "[\n"
        string += array.map { indentString + $0.serialize(self) }.joinWithSeparator(",\n")
        return string + " ]"
    }
    
    override internal func serializeObject(_ object: [String : Json]) -> String {
        indentLevel += 1
        defer {
            indentLevel -= 1
        }
        
        let indentString = indent()
        
        var string = "{\n"
        string += object.map({ indentString + "\(escapeAsJsonString($0)): \($1.serialize(self))" }).joinWithSeparator(",\n")
        string += " }"
        
        return string
    }
    
    func indent() -> String {
        return Array(1...indentLevel).map({ _ in " " }).joinWithSeparator("")
    }
}
