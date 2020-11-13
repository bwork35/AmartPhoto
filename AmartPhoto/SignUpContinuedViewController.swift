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
    var password: String?
    var role: User.Role = .client
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
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
        guard let password = password else {return}
        var phoneNumber = ""
        var brokerage = ""
        if let number = phoneNumberTextField.text {
            phoneNumber = number
        }
        if let company = brokerageTextField.text {
            brokerage = company
        }
//        let accountType: User.Role = role
        let accountType = role.rawValue
        
        
        UserController.shared.authAndCreateUser(email: email, password: password, firstName: firstName, lastName: lastName, brokerage: brokerage, phoneNumber: phoneNumber, role: accountType) {
            self.presentTransactionListVC()
        }
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //End of class
