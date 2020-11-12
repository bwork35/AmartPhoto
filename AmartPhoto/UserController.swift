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
    let db = Firestore.firestore()
    
    //MARK: - CRUD
    //Create
    func createUser(firstName: String, lastName: String, email: String, brokerage: String, phoneNumber: String, role: User.Role) {
        let newUser = User(id: 0, firstName: firstName, lastName: lastName, email: email, brokerage: brokerage, phoneNumber: phoneNumber, role: role, transactions: [], image: nil, brokerImage: nil)
        currentUser = newUser
    }
    
//    func createUser(id: String, firstName: String, lastName: String, email: String, brokerage: String, phoneNumber: String, role: User.Role) {
//
//    }
    
    func authAndCreateUser(email: String, password: String, firstName: String, lastName: String, brokerage: String, phoneNumber: String, role: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("There was an error authenticating a new user -- \(error) -- \(error.localizedDescription)")
            } else {
                self.db.collection("users").addDocument(data: [
                    "firstName": firstName,
                    "lastName": lastName,
                    "email": email,
                    "brokerage": brokerage,
                    "phoneNumber": phoneNumber,
                    "role": role,
                    "transactions": []
                ]) { (error) in
                    if let error = error {
                        print("There was an error saving to firestore -- \(error) -- \(error.localizedDescription)")
                    } else {
                        print("Successfully saved user.")
                    }
                }
            }
        }
    }
    
    func authUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("There was an error authenticating a new user -- \(error) -- \(error.localizedDescription)")
            } else {
                print(authResult as Any)
            }
        }
    }
    
    //Read (Fetch)
    func signInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("There was an error signing in a user -- \(error) -- \(error.localizedDescription)")
            } else {
                print("Successfully signed in user.")
            }
        }
    }
    
    func logOutUser() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
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
