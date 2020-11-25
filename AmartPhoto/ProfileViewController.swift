//
//  ProfileViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 10/29/20.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var brokerImage: UIImageView!
    @IBOutlet weak var brokerageLabel: UILabel!
    @IBOutlet weak var numProjectsCompletedLabel: UILabel!
    @IBOutlet weak var brokerageView: UIView!
    
    //MARK: - Properties
    var user: User?
    var myArray = ["198 Apple Road", "400 Blueberry Lane", "225 Cherry Street"]
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func editButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Select an image", message: "From where would you like to select an image?", preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
        
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        UserController.shared.logOutUser()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() else {return}
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let user = UserController.shared.currentUser else {return}
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        brokerageLabel.text = user.brokerage
        if let profile = user.image {
            profileImage.image = profile
        }
//        if user.role == .admin {
//            brokerageView.isHidden = true
//        }
        numProjectsCompletedLabel.text = "\(TransactionController.shared.confirmedTransactions.count)"
        if let userImage = user.image {
            profileImage.image = userImage
            profileImage.layer.cornerRadius = profileImage.frame.height / 2
            profileImage.clipsToBounds = true 
        }
    }

    //MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TransactionController.shared.confirmedTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "completedCell", for: indexPath) as? CompletedProjectsTableViewCell else {return UITableViewCell()}
        
        cell.transaction = TransactionController.shared.confirmedTransactions[indexPath.row]
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileToDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            guard let destination = segue.destination as? ProjectDetailViewController else {return}
            let transactionToSend = TransactionController.shared.confirmedTransactions[indexPath.row]
            destination.transaction = transactionToSend
        }
    }
} //End of class

extension ProfileViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImage = UIImage()
        if let img = info[.editedImage] as? UIImage {
            selectedImage = img
        } else if let img = info[.originalImage] as? UIImage {
            selectedImage = img
        }
        
        profileImage.image = selectedImage
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        
        guard let user = UserController.shared.currentUser else {return}
        user.image = selectedImage
        UserController.shared.updateUserImage()
        
        dismiss(animated: true, completion: nil)
    }
} //End of extension
