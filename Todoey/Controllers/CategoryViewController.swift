//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Shazeen Thowfeek on 16/10/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
//import SwipeCellKit

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        loadCategories()
        
    }
    
    //MARK: - Tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("cellforRowAtIndexPath Call")
        
       // let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
       cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
        //cell.delegate = self
        
        //cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].colour ?? "007AFF")
        
      
        return cell
    }
    
    //MARK: - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
    //MARK: - Data manipulation methods
    
    func save(category: Category){
        // let encoder = PropertyListEncoder()
        do{
            try realm.write{
                realm.add(category)
            }
            
        }catch{
            print("Error saving context,\(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
         categories = realm.objects(Category.self)
//        let  request: NSFetchRequest<Category> = Category.fetchRequest()
//        
//        do{
//            categories = try context.fetch(request)
//        }catch{
//            print("Error fetching data from context \(error)")
//        }
//        tableView.reloadData()
    }
    
  //MARK: - delete data from swipe
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryForDeletion = self.categories?[indexPath.row]{
            do{
                try self.realm.write{
                    self.realm.delete(categoryForDeletion)
                }
            }catch{
                print("Error deleting category,\(error)")
            }
           // tableView.reloadData()
        }
    }
    
    
    
    
    //MARK: - add new categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add ", style: .default) { (action) in
            // what will happen once the user clicks the add item button on our UIAlert
            //print(textField.text)
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
            //newCategory.colour = UIColor.randomFlat().hexValue()
            
            //newCategory.done = false
            //self.categories.append(newCategory)
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.save(category: newCategory)
        }
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField.placeholder = "Add a new category"
            textField = field
            
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
}


