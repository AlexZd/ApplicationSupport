//
//  Float+Extension.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/7/16.
//
//

extension Float: AnyType, DatabaseRepresentable {
    //MARK: - AnyType
    public var rawType: String { return "Float" }
    
    //MARK: - DatabaseRepresentable
    public var dbValue: AnyType { return self }
}

extension Float {
    //MARK: - Data
    var Kb: Float { return self * 1024 }
    var Mb: Float { return self.Kb * 1024 }
    var Gb: Float { return self.Mb * 1024 }
    
    //MARK: - Time
    var minutes: Float { return self * 60 }
    var hours: Float { return self.minutes * 60 }
    var days: Float { return self.hours * 24 }
    
    //MARK: - Distance
    var km: Float { return self * 1000 }
    var ml: Float { return self * 1609.34 }
}