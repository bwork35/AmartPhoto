//
//  AmartButton.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/5/20.
//

import UIKit

class AmartButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    func setupView() {
        self.layer.cornerRadius = 25.0
        self.clipsToBounds = true
    }
    
} //End of class
