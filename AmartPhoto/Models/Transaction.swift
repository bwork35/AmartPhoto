//
//  Transaction.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 10/27/20.
//

import Foundation

class Transaction {
    var id: String
    var status: Status
    var client: String
    var address: String
    var city: String
    var state: String
    var zip: String
    var sqFeet: String
    var isVacant: Bool
    var homeOwnerPhone: String
    var dateOne: String
    var timeOne: TimeOfDay
    var dateTwo: String
    var timeTwo: TimeOfDay
    var package: String
    var addOns: [String]
    var notes: String
    var timestamp: Date
    
    init(id: String = UUID().uuidString, status: Status, client: String, address: String, city: String, state: String, zip: String, sqFeet: String, isVacant: Bool, homeOwnerPhone: String, dateOne: String, timeOne: TimeOfDay, dateTwo: String, timeTwo: TimeOfDay, package: String, addOns: [String], notes: String, timestamp: Date = Date()) {
        self.id = id
        self.status = status
        self.client = client
        self.address = address
        self.city = city
        self.state = state
        self.zip = zip
        self.sqFeet = sqFeet
        self.isVacant = isVacant
        self.homeOwnerPhone = homeOwnerPhone
        self.dateOne = dateOne
        self.timeOne = timeOne
        self.dateTwo = dateTwo
        self.timeTwo = timeTwo
        self.package = package
        self.addOns = addOns
        self.notes = notes
        self.timestamp = timestamp
    }
    
    enum Status: String, CaseIterable, Codable, Hashable {
        case pending = "Pending"
        case confirmed = "Confirmed"
//        case approved = "Approved"
//        case completed = "Completed"
    }
    enum TimeOfDay: String, CaseIterable, Codable, Hashable {
        case morning = "Morning"
        case afternoon = "Afternoon"
        case any = "Any"
    }
} //End of class

extension Transaction: Equatable {
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.id == rhs.id && lhs.client == rhs.client && lhs.address == rhs.address
    }
} //End of extension
