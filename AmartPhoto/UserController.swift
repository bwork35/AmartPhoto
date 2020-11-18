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
    func createUser(id: String, firstName: String, lastName: String, email: String, brokerage: String, phoneNumber: String, role: User.Role) {
        let newUser = User(id: id, firstName: firstName, lastName: lastName, email: email, brokerage: brokerage, phoneNumber: phoneNumber, role: role, transactions: [], image: nil, brokerImage: nil)
        currentUser = newUser
    }
    
    func recreateUser(id: String, firstName: String, lastName: String, email: String, brokerage: String, phoneNumber: String, role: User.Role, transactions: [String]) {
        let newUser = User(id: id, firstName: firstName, lastName: lastName, email: email, brokerage: brokerage, phoneNumber: phoneNumber, role: role, transactions: transactions, image: nil, brokerImage: nil)
        currentUser = newUser
    }
    
    func authUser(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("There was an error authenticating a new user -- \(error) -- \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                guard let user = Auth.auth().currentUser else {return}
                let id = user.uid
                print(id)
                completion(.success(id))
            }
        }
    }
    
    func saveUser(id: String, email: String, firstName: String, lastName: String, brokerage: String, phoneNumber: String, role: String, completion: @escaping () -> Void) {
        self.db.collection("users").document(id).setData([
            "id": id,
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
                var accountType: User.Role = .client
                if role == "Administrator" {
                    accountType = .admin
                }
                self.createUser(id: id, firstName: firstName, lastName: lastName, email: email, brokerage: brokerage, phoneNumber: phoneNumber, role: accountType)
                completion()
            }
        }
    }
    
//    func authAndCreateUser(email: String, password: String, firstName: String, lastName: String, brokerage: String, phoneNumber: String, role: String, completion: @escaping () -> Void) {
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                print("There was an error authenticating a new user -- \(error) -- \(error.localizedDescription)")
//            } else {
////                guard let user = Auth.auth().currentUser else {return}
////                let id = user.uid
////                print(id)
//                self.db.collection("users").addDocument(data: [
//                    "firstName": firstName,
//                    "lastName": lastName,
//                    "email": email,
//                    "brokerage": brokerage,
//                    "phoneNumber": phoneNumber,
//                    "role": role,
//                    "transactions": []
//                ]) { (error) in
//                    if let error = error {
//                        print("There was an error saving to firestore -- \(error) -- \(error.localizedDescription)")
//                    } else {
//                        var accountType: User.Role = .client
//                        if role == "Client" {
//                            accountType = .client
//                        } else if role == "Administrator" {
//                            accountType = .admin
//                        }
//                        self.createUser(id: "", firstName: firstName, lastName: lastName, email: email, brokerage: brokerage, phoneNumber: phoneNumber, role: accountType)
//                        completion()
//                    }
//                }
//            }
//        }
//    }
    
//    func authUser(email: String, password: String) {
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                print("There was an error authenticating a new user -- \(error) -- \(error.localizedDescription)")
//            } else {
//                print(authResult as Any)
//            }
//        }
//    }
    
    //Read (Fetch)
    func fetchUser(email: String, completion: @escaping () -> Void) {
        db.collection("users").whereField("email", isEqualTo: email)
            .getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    guard let documents = querySnapshot?.documents else {return}
                    if !documents.isEmpty {
                        guard let doc = documents.first else {return}
                        let data = doc.data()
                        guard let userID = data["id"] as? String, let firstName = data["firstName"] as? String, let lastName = data["lastName"] as? String, let email = data["email"] as? String, let brokerage = data["brokerage"] as? String, let phoneNumber = data["phoneNumber"] as? String, let role = data["role"] as? String, let transactions = data["transactions"] as? [String] else {return}
                        var accountType: User.Role = .client
                        if role == "Administrator" {
                            accountType = .admin
                        }
                        self.recreateUser(id: userID, firstName: firstName, lastName: lastName, email: email, brokerage: brokerage, phoneNumber: phoneNumber, role: accountType, transactions: transactions)
                        
                        completion()
                    }
                }
            }
    }
    
    func signInUser(email: String, password: String, completion: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("There was an error signing in a user -- \(error) -- \(error.localizedDescription)")
            } else {
                print("Successfully signed in user.")
            }
            completion()
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
//    func updateUser(user: User, firstName: String, lastName: String, email: String, brokerage: String, phoneNumber: String, role: User.Role, transactions: [String], image: UIImage?, brokerImage: UIImage?) {
//        user.firstName = firstName
//        user.lastName = lastName
//        user.email = email
//        user.brokerage = brokerage
//        user.phoneNumber = phoneNumber
//        user.role = role
//        user.transactions = transactions
//        user.image = image
//        user.brokerImage = brokerImage
//    }
    
    func updateUserTransactions(completion: @escaping () -> Void) {
        guard let user = currentUser else {return}
        let userRef = db.collection("users").document(user.id)
        //whereField("id", isEqualTo: user.id)
        userRef.updateData([
            "transactions": user.transactions
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                completion()
            }
        }
    }
    
    //Delete
    func deleteUser() {
        currentUser = nil
    }
    
} //End of class
