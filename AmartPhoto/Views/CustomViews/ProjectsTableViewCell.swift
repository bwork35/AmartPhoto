//
//  ProjectsTableViewCell.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 10/29/20.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {

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
        guard let user = UserController.shared.currentUser else {return}
        guard let transaction = transaction else {return}
        if user.role == .client {
            topLabel.text = transaction.address
            bottomLabel.text = transaction.city
        } else if user.role == .admin {
            topLabel.text = transaction.client
            bottomLabel.text = transaction.address
        }
        statusLabel.text = "Status: \(transaction.status.rawValue)"
    }

} //End of class
