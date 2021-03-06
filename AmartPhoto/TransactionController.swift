//
//  TransactionController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/3/20.
//

import Foundation
import Firebase

class TransactionController {
    
    //MARK: - Properties
    static let shared = TransactionController()
    let db = Firestore.firestore()
    
    var transactions: [Transaction] = []
    var confirmedTransactions: [Transaction] = []
    
    //MARK: - CRUD
    //Create
    func createTransaction(client: String, address: String, city: String, state: String, zip: String, sqFeet: String, isVacant: Bool, homeOwnerPhone: String, dateOne: String, timeOne: Transaction.TimeOfDay, dateTwo: String, timeTwo: Transaction.TimeOfDay, package: String, addOns: [String], notes: String, completion: @escaping (Result<Transaction, Error>) -> Void) {
        let newTransaction = Transaction(status: .pending, client: client, address: address, city: city, state: state, zip: zip, sqFeet: sqFeet, isVacant: isVacant, homeOwnerPhone: homeOwnerPhone, dateOne: dateOne, timeOne: timeOne, dateTwo: dateTwo, timeTwo: timeTwo, package: package, addOns: addOns, notes: notes)
        
        self.transactions.append(newTransaction)
        completion(.success(newTransaction))
    }
    
    func recreateTransaction(transactionID: String, status: Transaction.Status, client: String, address: String, city: String, state: String, zip: String, sqFeet: String, isVacant: Bool, homeOwnerPhone: String, dateOne: String, timeOne: Transaction.TimeOfDay, dateTwo: String, timeTwo: Transaction.TimeOfDay, package: String, addOns: [String], notes: String) {
        let newTransaction = Transaction(status: status, client: client, address: address, city: city, state: state, zip: zip, sqFeet: sqFeet, isVacant: isVacant, homeOwnerPhone: homeOwnerPhone, dateOne: dateOne, timeOne: timeOne, dateTwo: dateTwo, timeTwo: timeTwo, package: package, addOns: addOns, notes: notes)
        newTransaction.id = transactionID
        
        if newTransaction.status == .confirmed {
            self.confirmedTransactions.append(newTransaction)
        } else {
            self.transactions.append(newTransaction)
        }
    }
    
//    func saveTransaction(id: String, status: String, client: String, address: String, city: String, state: String, zip: String, sqFeet: String, isVacant: Bool, homeOwnerPhone: String, dateOne: String, timeOne: String, dateTwo: String, timeTwo: String, package: String, addOns: [String], notes: String, completion: @escaping () -> Void) {
    func saveTransaction(transaction: Transaction, completion: @escaping () -> Void) {
        db.collection("transactions").document(transaction.id).setData([
            "status": transaction.status.rawValue,
            "client": transaction.client,
            "address": transaction.address,
            "city": transaction.city,
            "state": transaction.state,
            "zip": transaction.zip,
            "sqFeet": transaction.sqFeet,
            "isVacant": transaction.isVacant,
            "homeOwnerPhone": transaction.homeOwnerPhone,
            "dateOne": transaction.dateOne,
            "timeOne": transaction.timeOne.rawValue,
            "dateTwo": transaction.dateTwo,
            "timeTwo": transaction.timeTwo.rawValue,
            "package": transaction.package,
            "addOns": transaction.addOns,
            "notes": transaction.notes
        ]) { (error) in
            if let error = error {
                print("There was an error saving to firestore -- \(error) -- \(error.localizedDescription)")
            } else {
//                var transactionStatus: Transaction.Status = .pending
//                if status == "Confirmed" {
//                    transactionStatus = .confirmed
//                }
//                var tod1: Transaction.TimeOfDay = .any
//                if timeOne == "Morning" {
//                    tod1 = .morning
//                } else if timeOne == "Afternoon" {
//                    tod1 = .afternoon
//                }
//                var tod2: Transaction.TimeOfDay = .any
//                if timeTwo == "Morning" {
//                    tod2 = .morning
//                } else if timeOne == "Afternoon" {
//                    tod2 = .afternoon
//                }
//
//                self.createTransaction(status: transactionStatus, client: client, address: address, city: city, state: state, zip: zip, sqFeet: sqFeet, isVacant: isVacant, homeOwnerPhone: homeOwnerPhone, dateOne: dateOne, timeOne: tod1, dateTwo: dateTwo, timeTwo: tod2, package: package, addOns: addOns, notes: notes)
                guard let user = UserController.shared.currentUser else {return}
                user.transactions.append(transaction.id)
                UserController.shared.updateUserTransactions() {
                    completion()
                }
            }
        }
    }
    
    //Read (Fetch)
    func fetchTransactions(completion: @escaping () -> Void) {
        guard let currentUser = UserController.shared.currentUser else {return}
        let group = DispatchGroup()
        self.transactions = []
        self.confirmedTransactions = []
        for transactionID in currentUser.transactions {
            group.enter()
            let transactionRef = db.collection("transactions").document(transactionID)
            transactionRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    guard let data = document.data() else {return}
                    guard let status = data["status"] as? String, let client = data["client"] as? String, let address = data["address"] as? String, let city = data["city"] as? String, let state = data["state"] as? String, let zip = data["zip"] as? String, let sqFeet = data["sqFeet"] as? String, let isVacant = data["isVacant"] as? Bool, let homeOwnerPhone = data["homeOwnerPhone"] as? String, let dateOne = data["dateOne"] as? String, let timeOne = data["timeOne"] as? String, let dateTwo = data["dateTwo"] as? String, let timeTwo = data["timeTwo"] as? String, let package = data["package"] as? String, let addOns = data["addOns"] as? [String], let notes = data["notes"] as? String else {return}
                    var transactionStatus: Transaction.Status = .pending
                    if status == "Confirmed" {
                        transactionStatus = .confirmed
                    }
                    var tod1: Transaction.TimeOfDay = .any
                    if timeOne == "Morning" {
                        tod1 = .morning
                    } else if timeOne == "Afternoon" {
                        tod1 = .afternoon
                    }
                    var tod2: Transaction.TimeOfDay = .any
                    if timeTwo == "Morning" {
                        tod2 = .morning
                    } else if timeOne == "Afternoon" {
                        tod2 = .afternoon
                    }
                    self.recreateTransaction(transactionID: transactionID, status: transactionStatus, client: client, address: address, city: city, state: state, zip: zip, sqFeet: sqFeet, isVacant: isVacant, homeOwnerPhone: homeOwnerPhone, dateOne: dateOne, timeOne: tod1, dateTwo: dateTwo, timeTwo: tod2, package: package, addOns: addOns, notes: notes)
                    group.leave()
                } else {
                    print("Document does not exist")
                }
                group.notify(queue: .main) {
                    completion()
                }
            }
        }
    }
        
        func oldfetch() {
            
//            db.collection("transactions").whereField("id", isEqualTo: transactionID)
//                .getDocuments() { (querySnapshot, error) in
//                    if let error = error {
//                        print("Error getting documents: \(error)")
//                    } else {
//                        guard let documents = querySnapshot?.documents else {return}
//                        if !documents.isEmpty {
//                            guard let doc = documents.first else {return}
//                            let data = doc.data()
//
//                            guard let status = data["status"] as? String, let client = data["client"] as? String, let address = data["address"] as? String, let city = data["city"] as? String, let state = data["state"] as? String, let zip = data["zip"] as? String, let sqFeet = data["sqFeet"] as? String, let isVacant = data["isVacant"] as? Bool, let homeOwnerPhone = data["homeOwnerPhone"] as? String, let dateOne = data["dateOne"] as? String, let timeOne = data["timeOne"] as? String, let dateTwo = data["dateTwo"] as? String, let timeTwo = data["timeTwo"] as? String, let package = data["package"] as? String, let addOns = data["addOns"] as? [String], let notes = data["notes"] as? String else {return}
//                            var transactionStatus: Transaction.Status = .pending
//                            if status == "Confirmed" {
//                                transactionStatus = .confirmed
//                            }
//                            var tod1: Transaction.TimeOfDay = .any
//                            if timeOne == "Morning" {
//                                tod1 = .morning
//                            } else if timeOne == "Afternoon" {
//                                tod1 = .afternoon
//                            }
//                            var tod2: Transaction.TimeOfDay = .any
//                            if timeTwo == "Morning" {
//                                tod2 = .morning
//                            } else if timeOne == "Afternoon" {
//                                tod2 = .afternoon
//                            }
//                            self.recreateTransaction(status: transactionStatus, client: client, address: address, city: city, state: state, zip: zip, sqFeet: sqFeet, isVacant: isVacant, homeOwnerPhone: homeOwnerPhone, dateOne: dateOne, timeOne: tod1, dateTwo: dateTwo, timeTwo: tod2, package: package, addOns: addOns, notes: notes)
//
//
//                        }
//                    }
//        }
        
        
//        db.collection("transactions").whereField("client", isEqualTo: clientName)
//            .getDocuments() { (querySnapshot, error) in
//                if let error = error {
//                    print("Error getting documents: \(error)")
//                } else {
//                    self.transactions = []
//                    guard let documents = querySnapshot?.documents else {return}
//                    let group = DispatchGroup()
//                    for doc in documents {
//                        group.enter()
//                        let data = doc.data()
//                        let id = doc.documentID
//                        guard let status = data["status"] as? String, let client = data["client"] as? String, let address = data["address"] as? String, let city = data["city"] as? String, let state = data["state"] as? String, let zip = data["zip"] as? String, let sqFeet = data["sqFeet"] as? String, let isVacant = data["isVacant"] as? Bool, let homeOwnerPhone = data["homeOwnerPhone"] as? String, let dateOne = data["dateOne"] as? String, let timeOne = data["timeOne"] as? String, let dateTwo = data["dateTwo"] as? String, let timeTwo = data["timeTwo"] as? String, let package = data["package"] as? String, let addOns = data["addOns"] as? [String], let notes = data["notes"] as? String else {return}
//                        var transactionStatus: Transaction.Status = .pending
//                        if status == "Confirmed" {
//                            transactionStatus = .confirmed
//                        }
//                        var tod1: Transaction.TimeOfDay = .any
//                        if timeOne == "Morning" {
//                            tod1 = .morning
//                        } else if timeOne == "Afternoon" {
//                            tod1 = .afternoon
//                        }
//                        var tod2: Transaction.TimeOfDay = .any
//                        if timeTwo == "Morning" {
//                            tod2 = .morning
//                        } else if timeOne == "Afternoon" {
//                            tod2 = .afternoon
//                        }
//                        self.recreateTransaction(status: transactionStatus, client: client, address: address, city: city, state: state, zip: zip, sqFeet: sqFeet, isVacant: isVacant, homeOwnerPhone: homeOwnerPhone, dateOne: dateOne, timeOne: tod1, dateTwo: dateTwo, timeTwo: tod2, package: package, addOns: addOns, notes: notes)
//                        group.leave()
//                    }
//                    group.notify(queue: .main) {
//                        completion()
//                    }
//                }
//            }
    }
    
    func fetchAllTransactions(completion: @escaping () -> Void) {
        db.collection("transactions").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.transactions = []
                guard let documents = querySnapshot?.documents else {return}
                let group = DispatchGroup()
                for doc in documents {
                    group.enter()
                    let data = doc.data()
                    let id = doc.documentID
                    guard let status = data["status"] as? String, let client = data["client"] as? String, let address = data["address"] as? String, let city = data["city"] as? String, let state = data["state"] as? String, let zip = data["zip"] as? String, let sqFeet = data["sqFeet"] as? String, let isVacant = data["isVacant"] as? Bool, let homeOwnerPhone = data["homeOwnerPhone"] as? String, let dateOne = data["dateOne"] as? String, let timeOne = data["timeOne"] as? String, let dateTwo = data["dateTwo"] as? String, let timeTwo = data["timeTwo"] as? String, let package = data["package"] as? String, let addOns = data["addOns"] as? [String], let notes = data["notes"] as? String else {return}
                    var transactionStatus: Transaction.Status = .pending
                    if status == "Confirmed" {
                        transactionStatus = .confirmed
                    }
                    var tod1: Transaction.TimeOfDay = .any
                    if timeOne == "Morning" {
                        tod1 = .morning
                    } else if timeOne == "Afternoon" {
                        tod1 = .afternoon
                    }
                    var tod2: Transaction.TimeOfDay = .any
                    if timeTwo == "Morning" {
                        tod2 = .morning
                    } else if timeOne == "Afternoon" {
                        tod2 = .afternoon
                    }
                    self.recreateTransaction(transactionID: id, status: transactionStatus, client: client, address: address, city: city, state: state, zip: zip, sqFeet: sqFeet, isVacant: isVacant, homeOwnerPhone: homeOwnerPhone, dateOne: dateOne, timeOne: tod1, dateTwo: dateTwo, timeTwo: tod2, package: package, addOns: addOns, notes: notes)
                    group.leave()
                }
                group.notify(queue: .main) {
                    completion()
                }
            }
        }
    }
    
    //Update
    //    func updateTransaction(transaction: Transaction, address: String, city: String, state: String, zip: String, sqFeet: String, isVacant: Bool, homeOwnerPhone: String, dateOne: String, timeOne: Transaction.TimeOfDay, dateTwo: String, timeTwo: Transaction.TimeOfDay, package: String, addOns: [String], notes: String) {
    //        transaction.address = address
    //        transaction.city = city
    //        transaction.state = state
    //        transaction.zip = zip
    //        transaction.sqFeet = sqFeet
    //        transaction.isVacant = isVacant
    //        transaction.homeOwnerPhone = homeOwnerPhone
    //        transaction.dateOne = dateOne
    //        transaction.timeOne = timeOne
    //        transaction.dateTwo = dateTwo
    //        transaction.timeTwo = timeTwo
    //        transaction.package = package
    //        transaction.addOns = addOns
    //        transaction.notes = notes
    //    }
    //
    //    func updateTrans(transaction: Transaction, status: Transaction.Status) {
    //        transaction.status = status
    //    }
    
    func updateTransactionStatus(id: String) {        
        let transactionRef = db.collection("transactions").document(id)
        transactionRef.updateData([
            "status": "Confirmed"
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    //Delete
    func deleteTransaction(transaction: Transaction) {
        guard let index = transactions.firstIndex(of: transaction) else {return}
        transactions.remove(at: index)
    }
    
} //End of class
