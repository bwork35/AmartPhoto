//
//  User.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 10/27/20.
//

import UIKit

class User {
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    var brokerage: String
    var phoneNumber: String
    var role: Role
    var transactions: [Transaction]
    var image: UIImage?
    var brokerImage: UIImage?
    
    init(id: Int, firstName: String, lastName: String, email: String, brokerage: String, phoneNumber: String, role: Role, transactions: [Transaction], image: UIImage?, brokerImage: UIImage?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.brokerage = brokerage
        self.phoneNumber = phoneNumber
        self.role = role
        self.transactions = transactions
        self.image = image
        self.brokerImage = brokerImage
    }
    
    enum Role: String, CaseIterable, Codable, Hashable {
        case client = "Client"
        case admin = "Administrator"
    }
} //End of class

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id && lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.email == rhs.email && lhs.brokerage == rhs.brokerage && lhs.phoneNumber == rhs.phoneNumber && lhs.role == rhs.role && lhs.transactions == rhs.transactions && lhs.image == rhs.image && lhs.brokerImage == rhs.brokerImage
    }
} //End of extension
