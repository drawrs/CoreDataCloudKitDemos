//
//  ViewController.swift
//  CoreDataCloudKitDemos
//
//  Created by Rizal Hilman on 27/08/20.
//  Copyright © 2020 Rizal Hilman. All rights reserved.
//  This is a starter project

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Reference to managed object context
    let context = NSManagedObjectContext()
    
    // MARK: Data for the table
    var items: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchPeople()
    }
    
    func fetchPeople() {
        // MARK: Load person datas from coredata
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        // MARK: Create Alert
        let alert = UIAlertController(title: "Add Person", message: "What is their name?", preferredStyle: .alert)
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            guard let textField = alert.textFields?[0] else {return}
            
            // TODO: Create a person object
            
            // TODO: Save the data
            
            // TODO: Re-fetch the data
            
        }))
        
        // MARK: Show alert
        self.present(alert, animated: true, completion: nil)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        
        cell?.textLabel?.text = "Placeholder"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // MARK: Create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // TODO: Which person to remove
            
            // TODO: Remove the person
            
            // TODO: Save the data
            
            // TODO: Re-fetch the data
            
        }
        
        // MARK: Return swipe actions
        return UISwipeActionsConfiguration(actions: [action])
    }
}
