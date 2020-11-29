//
//  MenuViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/28/20.
//

import UIKit

protocol MenuSegueControllerDelegate: AnyObject {
    func segueWithString(id: String)
}

class MenuViewController: UIViewController {
    
    //MARK: - Outlets
    
    //MARK: - Properties
    weak var menuSegueDelegate: MenuSegueControllerDelegate?
    
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
        self.menuSegueDelegate?.segueWithString(id: "termsAndConditionsToInfoVC")
    }
    
    @IBAction func privacyPolicyButtonTapped(_ sender: Any) {
        self.menuSegueDelegate?.segueWithString(id: "privacyPolicyToInfoVC")
    }
    
    //MARK: - Helper Methods

    /*
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    */
    
} //End of class
