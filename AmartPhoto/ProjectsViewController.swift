//
//  ProjectsViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 10/29/20.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var plusButton: UIBarButtonItem!
    
    //MARK: - Properties
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setUpView()
        fetchTransactions()
        
        guard let user = UserController.shared.currentUser else {return}
        print(user.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    //MARK: - Helper Methods
    func setUpView() {
        if UserController.shared.currentUser?.role == .admin {
            plusButton.isEnabled = false
            plusButton.tintColor = .clear
        }
    }
    
    func fetchTransactions() {
        guard let user = UserController.shared.currentUser else {return}
        if user.role == .client {
            TransactionController.shared.fetchTransactions() {
                self.tableView.reloadData()
            }
        } else if user.role == .admin {
            TransactionController.shared.fetchAllTransactions() {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TransactionController.shared.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? ProjectsTableViewCell else {return UITableViewCell()}
        
        cell.transaction = TransactionController.shared.transactions[indexPath.row]
        
        print("*\n*\n*\(cell.transaction?.id)\n\(cell.transaction?.timestamp)\n*\n*\n")
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProjectListToDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            guard let destination = segue.destination as? ProjectDetailViewController else {return}
            let transactionToSend = TransactionController.shared.transactions[indexPath.row]
            destination.transaction = transactionToSend
        }
    }

} //End of class
