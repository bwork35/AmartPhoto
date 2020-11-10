//
//  LogInViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/5/20.
//

import UIKit

class LogInViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    //MARK: - Actions
    @IBAction func logInButtonTapped(_ sender: Any) {
        presentTransactionListVC()
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
        
        if passwordTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + 120
        } else if emailTextField.isEditing {
            self.view.frame.origin.y = 0 - keyboardSize.height + 120
        }
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
