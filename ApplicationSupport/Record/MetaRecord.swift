//
//  MetaRecord.swift
//  Pods
//
//  Created by Alex Zdorovets on 7/26/16.
//
//

import Foundation

public protocol Identifiable {
    var id : Any! { get set }
}

public protocol Initiable {
    init()
}

public protocol MetaRecord {
    static var modelName: String { get }
    static var modelsName: String { get }
    static var resourceName: String { get }
    static var resourcesName: String { get }
}

public extension MetaRecord {
    // Use debugPrint to receive nested classes names.
    public static var modelName: String {
        var className = ""
        debugPrint(self, separator: "", terminator: "", to: &className)
        return className.components(separatedBy: ".").dropFirst().joined(".").lowercased()
    }
    
    public static var modelsName: String {
        var className = ""
        debugPrint(self, separator: "", terminator: "", to: &className)
        return className.components(separatedBy: ".").dropFirst().joined(".").lowercased().pluralized
    }
}

public extension MetaRecord {
    // Returns in User.Session returns user/sessions
    public static var resourcesName: String {
        return self.resourceName.pluralized
    }
    
    public static var resourceName: String {
        let components = self.modelName.components(separatedBy: ".").map({ $0.lowercased() })
        return components.dropLast().joined(separator: "_") + (components.count > 1 ? "_" + components.last!.lowercased().pluralized : components.last!.lowercased())
    }
    
    public static var className: String {
        let component = self.modelName.components(separatedBy: ".").map({ $0.lowercased() }).last
        return component ?? ""
    }
}
