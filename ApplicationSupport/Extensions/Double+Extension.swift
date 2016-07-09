//
//  Double+Extension.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/7/16.
//
//

extension Double: AnyType, DatabaseRepresentable {
    //MARK: - AnyType
    public var rawType: String { return "Double" }
    
    //MARK: - DatabaseRepresentable
    public var dbValue: AnyType { return self }
}

extension Double {
    //MARK: - Data
    public var Kb: Double { return self * 1024 }
    public var Mb: Double { return self.Kb * 1024 }
    public var Gb: Double { return self.Mb * 1024 }
    
    //MARK: - Time
    public var minutes: Double { return self * 60 }
    public var hours: Double { return self.minutes * 60 }
    public var days: Double { return self.hours * 24 }
    
    //MARK: - Distance
    public var km: Double { return self * 1000 }
    public var ml: Double { return self * 1609.34 }
}