//
//  SignUpContinuedViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/5/20.
//

import UIKit

class SignUpContinuedViewController: UIViewController, UITextFieldDelegate {

    //MARK: - Outlets
    @IBOutlet weak var accountTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var brokerageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var clientInfoView: UIView!
    @IBOutlet weak var adminInfoView: UIView!
    @IBOutlet weak var companyTextField: UITextField!
    
    //MARK: - Properties
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var userID: String? {
        didSet {
            print("userID set")
        }
    }
    var role: User.Role = .client
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
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
        default:
            role = .client
            clientInfoView.isHidden = false
            adminInfoView.isHidden = true
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let firstName = firstName else {return}
        guard let lastName = lastName else {return}
        guard let email = email else {return}
        guard let password = password else {return}
        guard let userID = userID else {return}
        var phoneNumber = ""
        var brokerage = ""
        if let number = phoneNumberTextField.text {
            phoneNumber = number
        }
        if let company = brokerageTextField.text, !company.isEmpty {
            brokerage = company
        } else if let company = companyTextField.text, !company.isEmpty {
            brokerage = company 
        }
//        let accountType: User.Role = role
        let accountType = role.rawValue
        
        UserController.shared.saveUser(id: userID, email: email, firstName: firstName, lastName: lastName, brokerage: brokerage, phoneNumber: phoneNumber, role: accountType) {
            self.presentTransactionListVC()
        }
        
//        UserController.shared.authAndCreateUser(email: email, password: password, firstName: firstName, lastName: lastName, brokerage: brokerage, phoneNumber: phoneNumber, role: accountType) {
//            self.presentTransactionListVC()
//        }
    }
    
    //MARK: - Helper Methods
    func setUpView() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateTransactionContinuedViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateTransactionContinuedViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        }
        return true
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
