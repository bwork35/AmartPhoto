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
    
    //MARK: - Properties
    var transaction: Transaction?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let transaction = transaction else {return}
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
        //projectDetails
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
