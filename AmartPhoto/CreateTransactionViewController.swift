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
        setUpView()
        phoneNumberTextField.delegate = self
        zipcodeTextField.delegate = self 
    }
    
    //MARK: - Actions
    @IBAction func continueButtonTapped(_ sender: Any) {
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
    func setUpView() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateTransactionContinuedViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateTransactionContinuedViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        
        if phoneNumberTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + 50
        } else if sqftTextField.isEditing {
            self.view.frame.origin.y = 0 - 50
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateToCreate2" {
            guard let destination = segue.destination as? CreateTransactionContinuedViewController else {return}
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
            
            destination.address = address
            destination.city = city
            destination.state = state
            destination.zipcode = zipcode
            destination.sqft = sqft
            destination.phoneNumber = phoneNumber
            destination.homeIsVacant = homeIsVacant
            destination.dateOne = dateOne
            destination.timeOne = timeOne
            destination.dateTwo = dateTwo
            destination.timeTwo = timeTwo
        }
    }
} //End of class

extension CreateTransactionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            var strText: String? = textField.text
            if strText == nil {
                strText = ""
            }
            if string == "" {
                return true
            }
            if strText!.count == 3 || strText!.count == 7 {
                textField.text = "\(textField.text!)-\(string)"
                return false
            }
            let maxLength = 12
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        } else if textField == zipcodeTextField {
            let maxLength = 5
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
} //End of extension
