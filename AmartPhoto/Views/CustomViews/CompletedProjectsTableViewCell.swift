//
//  CompletedProjectsTableViewCell.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 10/29/20.
//

import UIKit

class CompletedProjectsTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    //MARK: - Properties
    var transaction: Transaction? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let transaction = transaction else {return}
        guard let currentUser = UserController.shared.currentUser else {return}
        if currentUser.role == .client {
            topLabel.text = transaction.address
            bottomLabel.text = transaction.city
        } else if currentUser.role == .admin {
            topLabel.text = transaction.client
            bottomLabel.text = transaction.address
        }
        statusLabel.text = "Status: \(transaction.status.rawValue)"
    }
    
} //End of class

