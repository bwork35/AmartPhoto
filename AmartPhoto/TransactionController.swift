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
    
    var transactions: [Transaction] = []
    
    //MARK: - CRUD
    //Create
    func createTransaction(address: String, city: String, state: String, zip: String, sqFeet: String, dateOne: String, timeOne: Transaction.TimeOfDay, dateTwo: String, timeTwo: Transaction.TimeOfDay, notes: String, isVacant: Bool, homeOwnerPhone: String) {
        let newTransaction = Transaction(id: 0, status: .pending, address: address, city: city, state: state, zip: zip, sqFeet: sqFeet, dateOne: dateOne, timeOne: timeOne, dateTwo: dateTwo, timeTwo: timeTwo, notes: notes, isVacant: isVacant, homeOwnerPhone: homeOwnerPhone)
        self.transactions.append(newTransaction)
    }
    
    //Read (Fetch)
    
    
    //Update
    func updateTransaction(transaction: Transaction, address: String, city: String, state: String, zip: String, sqFeet: String, dateOne: String, timeOne: Transaction.TimeOfDay, dateTwo: String, timeTwo: Transaction.TimeOfDay, notes: String, isVacant: Bool, homeOwnerPhone: String) {
        transaction.address = address
        transaction.city = city
        transaction.state = state
        transaction.zip = zip
        transaction.sqFeet = sqFeet
        transaction.dateOne = dateOne
        transaction.timeOne = timeOne
        transaction.dateTwo = dateTwo
        transaction.timeTwo = timeTwo
        transaction.notes = notes
        transaction.isVacant = isVacant
        transaction.homeOwnerPhone = homeOwnerPhone
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
