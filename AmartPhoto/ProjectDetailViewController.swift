//
//  ProjectDetailViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 10/29/20.
//

import UIKit

class ProjectDetailViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var squareFeetLabel: UILabel!
    @IBOutlet weak var vacantLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var primaryDateLabel: UILabel!
    @IBOutlet weak var secondaryDateLabel: UILabel!
    @IBOutlet weak var projectDetailsLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var clientNameView: UIView!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var totalViewHeight: NSLayoutConstraint!
    
    //MARK: - Properties
    var transaction: Transaction?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Actions
    @IBAction func confirmButtonTapped(_ sender: Any) {
        guard let transaction = transaction else {return}
        transaction.status = .confirmed
        confirmView.isHidden = true
        totalViewHeight.constant = 700
        
        guard let index = TransactionController.shared.transactions.firstIndex(of: transaction) else {return}
        TransactionController.shared.transactions.remove(at: index)
        TransactionController.shared.confirmedTransactions.append(transaction)
        
        TransactionController.shared.updateTransactionStatus(id: transaction.id)
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let transaction = transaction else {return}
        guard let user = UserController.shared.currentUser else {return}
        if user.role == .client {
            clientNameView.isHidden = true
            confirmView.isHidden = true
            totalViewHeight.constant = 700
        } else {
            clientNameView.isHidden = false
            clientNameLabel.text = transaction.client
            confirmView.isHidden = false
            totalViewHeight.constant = 800
        }
        
        addressLabel.text = "\(transaction.address) \(transaction.city), \(transaction.state)"
        squareFeetLabel.text = transaction.sqFeet
        if transaction.isVacant == false {
            vacantLabel.text = "No"
        } else {
            vacantLabel.text = "Yes"
        }
        phoneNumberLabel.text = transaction.homeOwnerPhone
        primaryDateLabel.text = "\(transaction.dateOne), \(transaction.timeOne)"
        secondaryDateLabel.text = "\(transaction.dateTwo), \(transaction.timeTwo)"
        
        let addOnDetails = transaction.addOns.joined(separator: ", ")
        projectDetailsLabel.text = "\(transaction.package) \n\(addOnDetails)"
        notesLabel.text = transaction.notes
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //End of class
