//
//  CreateTransactionViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 10/30/20.
//

import UIKit

class CreateTransactionViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var sqftTextField: UITextField!
    @IBOutlet weak var vacantSegmentedControl: UISegmentedControl!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var preferredDateDatePicker: UIDatePicker!
    @IBOutlet weak var preferredDateTimeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var secondaryDateDatePicker: UIDatePicker!
    @IBOutlet weak var secondaryDateTimeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var continueButton: UIButton!
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func continueButtonTapped(_ sender: Any) {
    }
    @IBAction func vacantSegmentedControlChanged(_ sender: Any) {
    }
    @IBAction func preferredDateSegmentedControlChanged(_ sender: Any) {
    }
    @IBAction func secondaryDateSegmentedControlChanged(_ sender: Any) {
    }
    
    //MARK: - Helper Methods
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //End of class
