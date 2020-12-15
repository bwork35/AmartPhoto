//
//  AmartTextField.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 12/15/20.
//

import UIKit

class AmartTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews(){
        self.layer.borderWidth = 0.7
        self.layer.borderColor = #colorLiteral(red: 0.8061969876, green: 0.83267802, blue: 0.8501111865, alpha: 1)
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
} //End of class



