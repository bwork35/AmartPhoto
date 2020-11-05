//
//  DateExtension.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/4/20.
//

import Foundation

extension Date {
    func dateAsString() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
