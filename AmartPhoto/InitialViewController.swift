//
//  InitialViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/11/20.
//

import UIKit
import Firebase

class InitialViewController: UIViewController {

    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
         checkUser()
    }
    
    //MARK: - Helper Methods
    func checkUser() {
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Amart", bundle: nil)
            guard let viewController = storyboard.instantiateInitialViewController() else {return}
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
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
