//
//  PackageCollectionViewCell.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/4/20.
//

import UIKit

protocol PackageSelectDelegate: AnyObject {
    func packageSelected(packageTitle: String)
}

class PackageCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var packageTitleLabel: UILabel!
    @IBOutlet weak var packageDescriptionLabel: UILabel!
    @IBOutlet weak var packageView: UIView!
    
    //MARK: - Properties
    var package: Package? {
        didSet {
            updateViews()
        }
    }
    weak var packageDelegate: PackageSelectDelegate?
    
    //MARK: - Actions
    @IBAction func selectPackageButtonTapped(_ sender: Any) {
        guard let packageTitle = packageTitleLabel.text else {return}
//        print(packageTitle)
        packageDelegate?.packageSelected(packageTitle: packageTitle)
    }
    
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let package = package else {return}
        packageTitleLabel.text = package.title
        packageDescriptionLabel.text = package.description
    }
    
} //End of class
