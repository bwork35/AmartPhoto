//
//  Transaction.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 10/27/20.
//

import Foundation

class Transaction {
    var id: Int
    var status: Status
    var address: String
    var city: String
    var state: String
    var zip: String
    var sqFeet: String
    var dateOne: String
    var timeOne: TimeOfDay
    var dateTwo: String
    var timeTwo: TimeOfDay
    var notes: String
    var isVacant: Bool
    var homeOwnerPhone: String
    
    init(id: Int, status: Status, address: String, city: String, state: String, zip: String, sqFeet: String, dateOne: String, timeOne: TimeOfDay, dateTwo: String, timeTwo: TimeOfDay, notes: String, isVacant: Bool, homeOwnerPhone: String) {
        self.id = id
        self.status = status
        self.address = address
        self.city = city
        self.state = state
        self.zip = zip
        self.sqFeet = sqFeet
        self.dateOne = dateOne
        self.timeOne = timeOne
        self.dateTwo = dateTwo
        self.timeTwo = timeTwo
        self.notes = notes
        self.isVacant = isVacant
        self.homeOwnerPhone = homeOwnerPhone
    }
    
    enum Status: String, CaseIterable, Codable, Hashable {
        case pending = "Pending"
        case approved = "Approved"
        case completed = "Completed"
    }
    enum TimeOfDay: String, CaseIterable, Codable, Hashable {
        case morning = "Morning"
        case afternoon = "Afternoon"
        case any = "Any"
    }
    
} //End of class