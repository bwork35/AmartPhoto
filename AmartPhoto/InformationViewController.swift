//
//  InformationViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/28/20.
//

import UIKit

class InformationViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var termsAndConditionsView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    
    
    //MARK: - Properties
    var isTermsAndConditions: Bool?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let isTermsAndConditions = isTermsAndConditions else {return}
        if isTermsAndConditions {
            termsAndConditionsView.isHidden = false
            privacyPolicyView.isHidden = true
        } else {
            termsAndConditionsView.isHidden = true
            privacyPolicyView.isHidden = false
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
