//
//  CreateTransactionContinuedViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/1/20.
//

import UIKit

class CreateTransactionContinuedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var packageCollectionView: UICollectionView!
    @IBOutlet weak var addOnCollectionView: UICollectionView!
    @IBOutlet weak var notesTextView: UITextView!
    
    //MARK: - Properties
    var address: String?
    var city: String?
    var state: String?
    var zipcode: String?
    var sqft: String?
    var phoneNumber: String?
    var homeIsVacant: Bool?
    var dateOne: String?
    var timeOne: Transaction.TimeOfDay?
    var dateTwo: String?
    var timeTwo: Transaction.TimeOfDay?
    var selectedPackage: String = ""
    var selectedAddOns: [String] = []
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextView()
        packageCollectionView.delegate = self
        packageCollectionView.dataSource = self
        packageCollectionView.allowsSelection = true
        addOnCollectionView.delegate = self
        addOnCollectionView.dataSource = self
        addOnCollectionView.allowsSelection = true
    }
    
    //MARK: - Actions
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let user = UserController.shared.currentUser else {return}
        let client = "\(user.firstName) \(user.lastName)"
        guard let address = address else {return}
        guard let city = city else {return}
        guard let state = state else {return}
        guard let zipcode = zipcode else {return}
        guard let sqft = sqft else {return}
        guard let phoneNumber = phoneNumber else {return}
        guard let homeIsVacant = homeIsVacant else {return}
        guard let dateOne = dateOne else {return}
        guard let timeOne = timeOne else {return}
        guard let dateTwo = dateTwo else {return}
        guard let timeTwo = timeTwo else {return}
        let package = ""
        let addOns = [""]
        var notes = ""
        if let notesField = notesTextView.text {
            notes = notesField
        }
        
        TransactionController.shared.createTransaction(client: client, address: address, city: city, state: state, zip: zipcode, sqFeet: sqft, isVacant: homeIsVacant, homeOwnerPhone: phoneNumber, dateOne: dateOne, timeOne: timeOne, dateTwo: dateTwo, timeTwo: timeTwo, package: package, addOns: addOns, notes: notes)
        navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: - Helper Methods
    func setUpTextView() {
        notesTextView.delegate = self
        notesTextView.layer.borderWidth = 0.5
        notesTextView.layer.borderColor = UIColor.black.cgColor
        notesTextView.layer.cornerRadius = 12.0
        notesTextView.layer.masksToBounds = true
        
        if notesTextView.text.isEmpty {
            notesTextView.text = "Write down any other info you'd like us to know!"
            notesTextView.textColor = UIColor.gray
        }
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateTransactionContinuedViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateTransactionContinuedViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        
        self.view.frame.origin.y = 0 - keyboardSize.height + 50
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    //MARK: - Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if collectionView == packageCollectionView {
            count = packageList.count
        } else if collectionView == addOnCollectionView {
            count = addOnList.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == packageCollectionView {
            guard let packageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "packageCell", for: indexPath) as? PackageCollectionViewCell else {return UICollectionViewCell()}
            cell = packageCell
            let package = packageList[indexPath.row]
            packageCell.package = package
            packageCell.packageDelegate = self
        } else if collectionView == addOnCollectionView {
            guard let addOnCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addOnCell", for: indexPath) as? AddOnCollectionViewCell else {return UICollectionViewCell()}
            cell = addOnCell
            let addOn = addOnList[indexPath.row]
            addOnCell.addOn = addOn
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? PackageCollectionViewCell {
//            guard let packageTitle = cell.packageTitleLabel.text else {return}
//            guard let view = cell.packageView else {return}
//            print(packageTitle)
//            view.backgroundColor = .cyan
//        } else if let cell = collectionView.cellForItem(at: indexPath) as? AddOnCollectionViewCell {
//            guard let addOnTitle = cell.addOnTitleLabel.text else {return}
//            guard let view = cell.addOnView else {return}
//            print(addOnTitle)
//            view.backgroundColor = .cyan
//        }
//
//        //        if collectionView == packageCollectionView {
//        //            print("package selected")
//        //        } else if collectionView == addOnCollectionView {
//        //            print("addOn selected")
//        //        }
//    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
} //End of class

extension CreateTransactionContinuedViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write down any other info you'd like us to know!" {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if textView == notesTextView {
                textView.text = "Write down any other info you'd like us to know!"
            }
            textView.textColor = UIColor.gray
        }
    }
} //End of extension

extension CreateTransactionContinuedViewController: PackageSelectDelegate {
    func packageSelected(packageTitle: String) {
        print(packageTitle)
    }
}
