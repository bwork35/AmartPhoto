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
    @IBOutlet weak var adminInfoView: UIView!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var signUpButton: AmartButton!
    
    //MARK: - Properties
    var firstName: String?
    var lastName: String?
    var email: String?
    var userID: String? {
        didSet {
            print("userID set")
        }
    }
    var role: User.Role = .client
    var phoneNumberIsEmpty = true 
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        signUpButton.isEnabled = false
        phoneNumberTextField.delegate = self
        adminInfoView.isHidden = true
    }
    
    //MARK: - Actions
    @IBAction func accountTypeSegmentedControlChanged(_ sender: Any) {
        switch accountTypeSegmentedControl.selectedSegmentIndex {
        case 1:
            role = .admin
            clientInfoView.isHidden = true
            adminInfoView.isHidden = false
            signUpButton.isEnabled = true
        default:
            role = .client
            clientInfoView.isHidden = false
            adminInfoView.isHidden = true
            if phoneNumberIsEmpty {
                signUpButton.isEnabled = false
            } else {
                signUpButton.isEnabled = true
            }
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let firstName = firstName else {return}
        guard let lastName = lastName else {return}
        guard let email = email else {return}
        guard let userID = userID else {return}
        var phoneNumber = ""
        var institution = ""
        if let number = phoneNumberTextField.text {
            phoneNumber = number
        }
        if let company = brokerageTextField.text, !company.isEmpty {
            institution = company
        } else if let company = companyTextField.text, !company.isEmpty {
            institution = company
        }
        let accountType = role.rawValue
        
        signUpButton.isEnabled = false
        
        UserController.shared.saveUser(id: userID, email: email, firstName: firstName, lastName: lastName, institution: institution, phoneNumber: phoneNumber, role: accountType) {
            self.presentTransactionListVC()
        }
    }
    
    //MARK: - Helper Methods
    func setUpView() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateTransactionContinuedViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateTransactionContinuedViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        accountTypeSegmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        accountTypeSegmentedControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
    
    func presentTransactionListVC() {
        let storyboard = UIStoryboard(name: "Amart", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() else {return}
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        self.view.frame.origin.y = 0 - keyboardSize.height + 100
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
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

extension SignUpContinuedViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case phoneNumberTextField:
            guard let text = textField.text else {return false}
            if (string == "") || (text.count < 11) {
                phoneNumberIsEmpty = true
            } else {
                phoneNumberIsEmpty = false
            }
        default:
            break
        }
        
        if (phoneNumberIsEmpty ==  false) {
            signUpButton.isEnabled = true
        } else {
            signUpButton.isEnabled = false
        }
        
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
        }
        
        return true
    }
} //End of extension 
