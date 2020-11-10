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
    
    init(id: Int, status: Status, client: String, address: String, city: String, state: String, zip: String, sqFeet: String, isVacant: Bool, homeOwnerPhone: String, dateOne: String, timeOne: TimeOfDay, dateTwo: String, timeTwo: TimeOfDay, package: String, addOns: [String], notes: String) {
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
        return lhs.id == rhs.id && lhs.status == rhs.status && lhs.client == rhs.client && lhs.address == rhs.address && lhs.city == rhs.city && lhs.state == rhs.state && lhs.zip == rhs.zip && lhs.sqFeet == rhs.sqFeet && lhs.isVacant == rhs.isVacant && lhs.homeOwnerPhone == rhs.homeOwnerPhone && lhs.dateOne == rhs.dateOne && lhs.timeOne == rhs.timeOne && lhs.dateTwo == rhs.dateTwo && lhs.timeTwo == rhs.timeTwo && lhs.package == rhs.package && lhs.addOns == rhs.addOns && lhs.notes == rhs.notes
    }
} //End of extension
