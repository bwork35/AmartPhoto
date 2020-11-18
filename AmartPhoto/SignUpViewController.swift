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
    
    //MARK: - Properties
    var userID: String?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    //MARK: - Actions
    @IBAction func continueButtonTapped(_ sender: Any) {
//        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {return}
//        guard let lastName = lastNameTextField.text, !lastName.isEmpty else {return}
        guard let email = emailTextField.text, !email.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return}
        
        UserController.shared.authUser(email: email, password: password) { (result) in
            switch result {
            case .success(let id):
                self.userID = id
                self.performSegue(withIdentifier: "signUpToSignUpContinued", sender: self)
            case .failure(_):
                print("failure")
            }
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
        
        if passwordTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + 100
        } else if emailTextField.isEditing {
            self.view.frame.origin.y = 0 - 100
        } else if lastNameTextField.isEditing {
            self.view.frame.origin.y = 0 - 50
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {return}
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else {return}
        guard let email = emailTextField.text, !email.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return}
        guard let userID = userID else {return}
        
        if segue.identifier == "signUpToSignUpContinued" {
            guard let destination = segue.destination as? SignUpContinuedViewController else {return}
            destination.firstName = firstName
            destination.lastName = lastName
            destination.email = email
            destination.password = password
            destination.userID = userID
        }
    }

} //End of class
