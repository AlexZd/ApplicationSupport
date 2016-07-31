//
//  Record.swift
//  Pods
//
//  Created by Alex Zdorovets on 7/26/16.
//
//

import Foundation

//extension JSON {
//    public init(_ object: RecordObject) {
//        self.init(NSObject())
//        self.object = object.pure
//    }
//    
//    public init(_ object: RecordsArray) {
//        self.init(NSObject())
//        self.object = object.map({ $0.pure })
//    }
//    
//    //Optional [String : Any]
//    public var recordObject: RecordObject? {
//        get { return self.dictionaryObject?.pure }
//        set {
//            if let v = newValue {
//                self.object = v.pure
//            } else {
//                self.object = NSNull()
//            }
//        }
//    }
//    
//    //Optional [Any]
//    public var recordsObject: RecordsArray? {
//        get { return self.arrayObject?.flatMap({ ($0 as? RecordObject)?.pure }) }
//        set {
//            if let array = newValue {
//                self.object = array.map({ $0.pure })
//            } else {
//                self.object = NSNull()
//            }
//        }
//    }
//    
//    public var dateObject: NSDate? {
//        if let string = self.string {
//            return DateFormatter.API.dateFromString(string)
//        }
//        return nil
//    }
//}

public typealias RecordObject = [String: Any]
public typealias RecordsArray = [RecordObject]

public protocol Record: MetaRecord, Initiable {
    var timeline: Timeline { get set }
    
    func setAttributes(attributes: RecordObject)
    func getAttributes() -> RecordObject
    
    func setAttributes(action: String, attributes: RecordObject)
    func getAttributes(action: String) -> RecordObject
}

public extension Record {
    public func setAttributes(attributes: RecordObject) {}
    public func getAttributes() -> RecordObject { return RecordObject() }
    
    public func setAttributes(action: String, attributes: RecordObject) {}
    public func getAttributes(action: String) -> RecordObject { return RecordObject() }
}

public extension Record {
    public init(attributes: RecordObject, action: String) {
        self.init()
        self.setAttributes(action, attributes: attributes)
    }
}

public extension Record {
    // Returns in User.Session returns user/sessions
    public static var resourcesName: String {
        return self.resourceName.pluralized
    }
    
    public static var resourceName: String {
        let components = self.modelName.componentsSeparatedByString(".").map({ $0.lowercaseString })
        return components.dropLast().joinWithSeparator("_") + (components.count > 1 ? "_" + components.last!.lowercaseString.pluralized : components.last!.lowercaseString)
    }
}