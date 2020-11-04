//
//  PackageCollectionViewCell.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/4/20.
//

import UIKit

class PackageCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var packageTitleLabel: UILabel!
    @IBOutlet weak var packageDescriptionLabel: UILabel!
    
    //MARK: - Properties
    var package: Package? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Actions
    
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let package = package else {return}
        packageTitleLabel.text = package.title
        packageDescriptionLabel.text = package.description
    }
    
} //End of class
