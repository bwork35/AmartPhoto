//
//  TransactionController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/3/20.
//

import Foundation

class TransactionController {
    
    //MARK: - Properties
    static let shared = TransactionController()
    
    var transactions: [Transaction] = {
        return [Transaction(id: 0, status: .pending, client: "Bryan Workman", address: "711 Pennwood Dr.", city: "McDonald", state: "PA", zip: "15057", sqFeet: "1234", isVacant: true, homeOwnerPhone: "724-746-8859", dateOne: "Nov 15", timeOne: .morning, dateTwo: "Nov 16", timeTwo: .afternoon, package: "Photo Package", addOns: ["Twilight Photos", "Local Footage"], notes: "the quick brown fox...")]
    }()
    
    //MARK: - CRUD
    //Create
    func createTransaction(client: String, address: String, city: String, state: String, zip: String, sqFeet: String, isVacant: Bool, homeOwnerPhone: String, dateOne: String, timeOne: Transaction.TimeOfDay, dateTwo: String, timeTwo: Transaction.TimeOfDay, package: String, addOns: [String], notes: String) {
        let newTransaction = Transaction(id: 0, status: .pending, client: client, address: address, city: city, state: state, zip: zip, sqFeet: sqFeet, isVacant: isVacant, homeOwnerPhone: homeOwnerPhone, dateOne: dateOne, timeOne: timeOne, dateTwo: dateTwo, timeTwo: timeTwo, package: package, addOns: addOns, notes: notes)
        self.transactions.append(newTransaction)
    }
    
    //Read (Fetch)
    
    
    //Update
    func updateTransaction(transaction: Transaction, address: String, city: String, state: String, zip: String, sqFeet: String, isVacant: Bool, homeOwnerPhone: String, dateOne: String, timeOne: Transaction.TimeOfDay, dateTwo: String, timeTwo: Transaction.TimeOfDay, package: String, addOns: [String], notes: String) {
        transaction.address = address
        transaction.city = city
        transaction.state = state
        transaction.zip = zip
        transaction.sqFeet = sqFeet
        transaction.isVacant = isVacant
        transaction.homeOwnerPhone = homeOwnerPhone
        transaction.dateOne = dateOne
        transaction.timeOne = timeOne
        transaction.dateTwo = dateTwo
        transaction.timeTwo = timeTwo
        transaction.package = package
        transaction.addOns = addOns
        transaction.notes = notes
        
    }
    
    func updateTrans(transaction: Transaction, status: Transaction.Status) {
        transaction.status = status
    }
    
    //Delete
    func deleteTransaction(transaction: Transaction) {
        guard let index = transactions.firstIndex(of: transaction) else {return}
        transactions.remove(at: index)
    }
    
} //End of class
