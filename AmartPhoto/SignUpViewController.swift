//
//  SignUpViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/5/20.
//

import UIKit

class SignUpViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func continueButtonTapped(_ sender: Any) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {return}
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else {return}
        guard let email = emailTextField.text, !email.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return} 
    }
    
    //MARK: - Helper Methods
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {return}
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else {return}
        guard let email = emailTextField.text, !email.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return}
        
        if segue.identifier == "signUpToSignUpContinued" {
            guard let destination = segue.destination as? SignUpContinuedViewController else {return}
            destination.firstName = firstName
            destination.lastName = lastName
            destination.email = email
        }
    }

} //End of class
