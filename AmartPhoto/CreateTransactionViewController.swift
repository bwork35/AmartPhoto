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
    var isVacant = false
    var preferredTime: Transaction.TimeOfDay = .morning
    var secondaryTime: Transaction.TimeOfDay = .morning
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func continueButtonTapped(_ sender: Any) {
        guard let address = addressTextField.text, !address.isEmpty else {return}
        guard let city = cityTextField.text, !city.isEmpty else {return}
        guard let state = stateTextField.text, !state.isEmpty else {return}
        guard let zipcode = zipcodeTextField.text, !zipcode.isEmpty else {return}
        guard let sqft = sqftTextField.text, !sqft.isEmpty else {return}
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {return}
        let homeIsVacant = self.isVacant
        let dateOne = preferredDateDatePicker.date.dateAsString()
        let timeOne = self.preferredTime
        let dateTwo = secondaryDateDatePicker.date.dateAsString()
        let timeTwo = self.secondaryTime
        
//        print("date 1: \(dateOne)")
//        print("date 2: \(dateTwo)")
//        print("isVacant: \(homeIsVacant)")
//        print("time 1 : \(timeOne)")
//        print("time 2 : \(timeTwo)")
        
        TransactionController.shared.createTransaction(address: address, city: city, state: state, zip: zipcode, sqFeet: sqft, dateOne: dateOne, timeOne: timeOne, dateTwo: dateTwo, timeTwo: timeTwo, notes: "", isVacant: homeIsVacant, homeOwnerPhone: phoneNumber)
    }
    
    @IBAction func vacantSegmentedControlChanged(_ sender: Any) {
        switch vacantSegmentedControl.selectedSegmentIndex {
        case 1:
            isVacant = true
        default:
            isVacant = false
        }
    }
    
    @IBAction func preferredDateSegmentedControlChanged(_ sender: Any) {
        switch preferredDateTimeSegmentedControl.selectedSegmentIndex {
        case 1:
            preferredTime = .afternoon
        case 2:
            preferredTime = .any
        default:
            preferredTime = .morning
        }
    }
    
    @IBAction func secondaryDateSegmentedControlChanged(_ sender: Any) {
        switch secondaryDateTimeSegmentedControl.selectedSegmentIndex {
        case 1:
            secondaryTime = .afternoon
        case 2:
            secondaryTime = .any
        default:
            secondaryTime = .morning
        }
    }
    
    //MARK: - Helper Methods
    

    
    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "CreateToCreate2" {
//
//        }
//    }
    

} //End of class
