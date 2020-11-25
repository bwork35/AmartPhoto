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
    @IBOutlet weak var continueButton: AmartButton!
    
    //MARK: - Properties
    var userID: String?
    var firstNameIsEmpty = true
    var lastNameIsEmpty = true
    var emailIsEmpty = true
    var passwordIsEmpty = true
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        continueButton.isEnabled = false
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    //MARK: - Actions
    @IBAction func continueButtonTapped(_ sender: Any) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {return}
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else {return}
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

extension SignUpViewController: UITextFieldDelegate {
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == firstNameTextField {
//            guard let text = textField.text else {return}
//            if text.isEmpty {
//                firstNameIsEmpty = true
//            } else {
//                firstNameIsEmpty = false
//            }
//        } else if textField == lastNameTextField {
//            guard let text = textField.text else {return}
//            if text.isEmpty {
//                lastNameIsEmpty = true
//            } else {
//                lastNameIsEmpty = false
//            }
//        } else if textField == emailTextField {
//            guard let text = textField.text else {return}
//            if text.isEmpty {
//                emailIsEmpty = true
//            } else {
//                emailIsEmpty = false
//            }
//        } else if textField == passwordTextField {
//            guard let text = textField.text else {return}
//            if text.isEmpty {
//                passwordIsEmpty = true
//            } else {
//                passwordIsEmpty = false
//            }
//        }
//
//        if (firstNameIsEmpty ==  false) && (lastNameIsEmpty ==  false) && (emailIsEmpty ==  false) && (passwordIsEmpty == false) {
//            continueButton.isEnabled = true
//        } else {
//            continueButton.isEnabled = false
//        }
        
        
//        switch textField {
//        case firstNameTextField:
//            print("firstName")
//        case lastNameTextField:
//            print("lastName")
//        case emailTextField:
//            print("email")
//        case passwordTextField:
//            print("password")
//        default:
//            print("uh oh")
//        }
//
//
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case firstNameTextField:
            guard let text = textField.text else {return false}
            if string == "" && text.count == 1 {
                firstNameIsEmpty = true
            } else {
                firstNameIsEmpty = false
            }
        case lastNameTextField:
            guard let text = textField.text else {return false}
            if string == "" && text.count == 1 {
                lastNameIsEmpty = true
            } else {
                lastNameIsEmpty = false
            }
        case emailTextField:
            guard let text = textField.text else {return false}
            if string == "" && text.count == 1 {
                emailIsEmpty = true
            } else {
                emailIsEmpty = false
            }
        case passwordTextField:
            guard let text = textField.text else {return false}
            if string == "" && text.count == 1 {
                passwordIsEmpty = true
            } else {
                passwordIsEmpty = false
            }
        default:
            print("uh oh")
        }
        
        if (firstNameIsEmpty ==  false) && (lastNameIsEmpty ==  false) && (emailIsEmpty ==  false) && (passwordIsEmpty == false) {
            continueButton.isEnabled = true
        } else {
            continueButton.isEnabled = false
        }
        
        return true
    }
} //End of extension
