//
//  MenuViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/28/20.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func hideMenu()
}

class MenuViewController: UIViewController {
    
    //MARK: - Outlets
    
    //MARK: - Properties
    weak var menuDelegate: MenuViewControllerDelegate?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func logOutButtonTapped(_ sender: Any) {
        UserController.shared.logOutUser()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() else {return}
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
    @IBAction func termsAndConditionsButtonTapped(_ sender: Any) {
        self.menuDelegate?.hideMenu()
    }
    
    @IBAction func privacyPolicyButtonTapped(_ sender: Any) {
        self.menuDelegate?.hideMenu()
    }
    
    //MARK: - Helper Methods
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "privacyPolicyToInfoVC" {
            guard let destination = segue.destination as? InformationViewController else {return}
            destination.isTermsAndConditions = false
        } else if segue.identifier == "termsAndConditionsToInfoVC" {
            guard let destination = segue.destination as? InformationViewController else {return}
            destination.isTermsAndConditions = true
        }
    }
} //End of class
