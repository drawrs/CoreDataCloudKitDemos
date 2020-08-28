//
//  ViewController.swift
//  CoreDataCloudKitDemos
//
//  Created by Rizal Hilman on 27/08/20.
//  Copyright © 2020 Rizal Hilman. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    // MARK: Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: Data for the table
    var items: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchPeople()
        
//        relationshipDemo()
//        fetchFamily()
    }
    
    func fetchPeople() {
        // MARK: Load person datas from coredata
        do {
            
//            // MARK: Filtering & Sorting
//            let request = Person.fetchRequest() as NSFetchRequest<Person>
//
//            // Set filter
//            let predicate = NSPredicate(format: "name CONTAINS %@", "Seto")
//            request.predicate = predicate
//
//            // Set sorting
//            let sort = NSSortDescriptor(key: "name", ascending: true)
//            request.sortDescriptors = [sort]
//
//            self.items = try context.fetch(request)
            
            // MARK: Fetch person entity
            self.items = try context.fetch(Person.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData() // Reload table view
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func addTaped(_ sender: Any) {
        // MARK: Create Alert
        let alert = UIAlertController(title: "Add Person", message: "What is their name?", preferredStyle: .alert)
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            guard let textField = alert.textFields?[0] else {return}
            let name = textField.text ?? ""
            
            // TODO: Create a person object
            let newPerson = Person(context: self.context)
            newPerson.name = name
            newPerson.age = 20
            newPerson.gender = "Male"
            
            // TODO: Save the data
            do {
                try self.context.save()
            } catch {
                print(error)
            }
            
            // TODO: Re-fetch the data
            self.fetchPeople()
        }))
        
        // MARK: Show alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Relationship
    func relationshipDemo(){
        // Create a family
        let family = Family(context: context)
        family.name = "Keluarga Matahari"
        
        
        // Create a person
        let person = Person(context: context)
        person.name = "Ahmad"
        
//        person.family = family // 1st way
        family.addToPeople(person) // 2nd way
        
        // Save context
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func fetchFamily() {
        do {
            let families = try context.fetch(Family.fetchRequest()) as [Family]
            for family in families {
                let persons = family.people?.allObjects as! [Person]
                for person in persons {
                    print(person.name)
                }
            }
        } catch {
            print(error)
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        
        let person = self.items![indexPath.row]
        
        cell?.textLabel?.text = person.name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // MARK: Create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // TODO: Which person to remove
            let personToRemove = self.items![indexPath.row]
            
            // TODO: Remove the person
            self.context.delete(personToRemove)
            
            // TODO: Save the data
            do {
                try self.context.save()
            } catch {
                print(error)
            }
            
            // TODO: Re-fetch the data
            self.fetchPeople()
        }
        
        // MARK: Return swipe actions
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Selected Person
        let person = self.items![indexPath.row]
        
//        // To see family relationship
//        person.family.map {
//            print($0.name)
//        }
        
        // Create alert
        let alert = UIAlertController(title: "Edit Person", message: "Edit name:", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = person.name
        }
        
        // Configure button handler
        let saveButton = UIAlertAction(title: "Save", style: .destructive) { (action) in
            // Get the textfield for the alert
            guard let textField = alert.textFields?[0] else {return}
            
            // TODO: Edit name peroperty of person object
            person.name = textField.text ?? ""
            
            // TODO: Save the data
            do {
                try self.context.save()
            } catch {
                print(error)
            }
            
            // TODO: Re-fetch the data
            self.fetchPeople()
        }
        
        // Add Button
        alert.addAction(saveButton)
        
        // Show alert
        self.present(alert, animated: true, completion: nil)
    }
}
