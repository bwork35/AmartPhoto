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
    fileprivate var imageName: String
    var image: UIImage?
    var brokerImage: UIImage?
//    fileprivate var brokerImageName: String
    
    init(id: Int, firstName: String, lastName: String, email: String, brokerage: String, phoneNumber: String, role: Role, transactions: [Transaction], image: UIImage?, brokerImage: UIImage?, brokerImageName: String) {
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

//extension User {
//    var image: Image {
//        ImageStore.shared.image(name: imageName)
//    }
//    var brokerImage: Image {
//        ImageStore.shared.image(name: brokerImageName)
//    }
//}
