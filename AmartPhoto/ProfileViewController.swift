//
//  ProfileViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 10/29/20.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var brokerImage: UIImageView!
    @IBOutlet weak var brokerageLabel: UILabel!
    @IBOutlet weak var numProjectsCompletedLabel: UILabel!
    
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
    
    //MARK: - Actions
    @IBAction func editButtonTapped(_ sender: Any) {
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let user = UserController.shared.currentUser else {return}
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        brokerageLabel.text = user.brokerage
        if let profile = user.image {
            profileImage.image = profile
        }
        
    }

    //MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "completedCell", for: indexPath) as? CompletedProjectsTableViewCell else {return UITableViewCell()}
        
        cell.myString = myArray[indexPath.row]
        
        return cell
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
