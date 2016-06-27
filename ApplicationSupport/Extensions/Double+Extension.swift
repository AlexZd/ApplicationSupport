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
    var Kb: Double { return self * 1024 }
    var Mb: Double { return self.Kb * 1024 }
    var Gb: Double { return self.Mb * 1024 }
    
    //MARK: - Time
    var minutes: Double { return self * 60 }
    var hours: Double { return self.minutes * 60 }
    var days: Double { return self.hours * 24 }
    
    //MARK: - Distance
    var km: Double { return self * 1000 }
    var ml: Double { return self * 1609.34 }
}