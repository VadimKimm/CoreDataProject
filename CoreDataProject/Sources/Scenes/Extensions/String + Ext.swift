//
//  String + Ext.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 17.08.2022.
//

import Foundation

extension String {
    public func convertToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.date(from: self)
    }
}
