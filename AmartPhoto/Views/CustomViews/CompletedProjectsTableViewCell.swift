//
//  CompletedProjectsTableViewCell.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 10/29/20.
//

import UIKit

class CompletedProjectsTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    //MARK: - Properties
    var myString: String? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let myString = myString else {return}
        addressLabel.text = myString
    }
    
    
} //End of class

