//
//  ProjectsTableViewCell.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 10/29/20.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
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
        addressLabel.text = transaction.address
        cityLabel.text = transaction.city
        statusLabel.text = "Status: \(transaction.status)"
    }

} //End of class
