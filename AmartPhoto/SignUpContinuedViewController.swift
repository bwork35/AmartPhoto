//
//  SignUpContinuedViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/5/20.
//

import UIKit

class SignUpContinuedViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var accountTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var brokerageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var clientInfoView: UIView!
    
    //MARK: - Properties
    var firstName: String?
    var lastName: String?
    var email: String?
    var role: User.Role = .client
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func accountTypeSegmentedControlChanged(_ sender: Any) {
        switch accountTypeSegmentedControl.selectedSegmentIndex {
        case 1:
            role = .admin
            clientInfoView.isHidden = true
        default:
            role = .client
            clientInfoView.isHidden = false
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let firstName = firstName else {return}
        guard let lastName = lastName else {return}
        guard let email = email else {return}
        var phoneNumber = ""
        var brokerage = ""
        if let number = phoneNumberTextField.text {
            phoneNumber = number
        }
        if let company = brokerageTextField.text {
            brokerage = company
        }
        let accountType: User.Role = role
        
        UserController.shared.createUser(firstName: firstName, lastName: lastName, email: email, brokerage: brokerage, phoneNumber: phoneNumber, role: accountType)
        
        presentTransactionListVC()
    }
    
    //MARK: - Helper Methods
    func presentTransactionListVC() {
        let storyboard = UIStoryboard(name: "Amart", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() else {return}
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
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
