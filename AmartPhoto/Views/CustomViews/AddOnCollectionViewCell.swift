//
//  AddOnCollectionViewCell.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/4/20.
//

import UIKit

class AddOnCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var addOnTitleLabel: UILabel!
    @IBOutlet weak var addOnDescriptionLabel: UILabel!
    
    //MARK: - Properties
    var addOn: AddOn? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Actions

    
    //MARK: - Helper Methods
    func updateViews() {
        guard let addOn = addOn else {return}
        addOnTitleLabel.text = addOn.title
        addOnDescriptionLabel.text = addOn.description
    }
    
} //End of class
