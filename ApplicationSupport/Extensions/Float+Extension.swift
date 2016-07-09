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
    public var Kb: Float { return self * 1024 }
    public var Mb: Float { return self.Kb * 1024 }
    public var Gb: Float { return self.Mb * 1024 }
    
    //MARK: - Time
    public var minutes: Float { return self * 60 }
    public var hours: Float { return self.minutes * 60 }
    public var days: Float { return self.hours * 24 }
    
    //MARK: - Distance
    public var km: Float { return self * 1000 }
    public var ml: Float { return self * 1609.34 }
}