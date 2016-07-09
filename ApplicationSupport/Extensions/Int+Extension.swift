//
//  Int+Extension.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/7/16.
//
//

extension Int: AnyType, DatabaseRepresentable {
    //MARK: - AnyType
    public var rawType: String { return "Int" }
    
    //MARK: - DatabaseRepresentable
    public var dbValue: AnyType { return self }
}

extension Int {
    //MARK: - Data
    public var Kb: Int { return self * 1024 }
    public var Mb: Int { return self.Kb * 1024 }
    public var Gb: Int { return self.Mb * 1024 }

    //MARK: - Time
    public var minutes: Int { return self * 60 }
    public var hours: Int { return self.minutes * 60 }
    public var days: Int { return self.hours * 24 }
    
    //MARK: - Distance
    public var km: Int { return self * 1000 }
    public var ml: Int { return Int(Double(self) * 1609.34) }
}
