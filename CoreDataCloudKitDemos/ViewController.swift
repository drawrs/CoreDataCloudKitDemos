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
    
    // Reference to managed object context
    let context = NSManagedObjectContext()
    
    // Data for the table
    var items: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchPeople() {
        
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
    
    
}
