//
//  UserController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/3/20.
//

import UIKit
import Firebase

class UserController {
    
    //MARK: - Properties
    static let shared = UserController()
    var currentUser: User?
    
    //MARK: - CRUD
    //Create
    func createUser(firstName: String, lastName: String, email: String, brokerage: String, phoneNumber: String, role: User.Role) {
        let newUser = User(id: 0, firstName: firstName, lastName: lastName, email: email, brokerage: brokerage, phoneNumber: phoneNumber, role: role, transactions: [], image: nil, brokerImage: nil)
        currentUser = newUser
    }
    
    func authUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("There was an error authenticating a new user -- \(error) -- \(error.localizedDescription)")
            }
        }
    }
    
    //Read (Fetch)
    
    
    //Update
    func updateUser(user: User, firstName: String, lastName: String, email: String, brokerage: String, phoneNumber: String, role: User.Role, transactions: [Transaction], image: UIImage?, brokerImage: UIImage?) {
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        user.brokerage = brokerage
        user.phoneNumber = phoneNumber
        user.role = role
        user.transactions = transactions
        user.image = image
        user.brokerImage = brokerImage
    }
    
    //Delete
    func deleteUser() {
        currentUser = nil
    }
    
} //End of class
