//
//  Date + Ext.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 17.08.2022.
//

import Foundation

extension Date {
    public func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
