//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ToDoListViewController: SwipeTableViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var todoItems: Results<Item>?
    var realm = try! Realm()
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    //    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //let defaults = UserDefaults.standard
    //    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        title = selectedCategory!.name
        
      
//        if let colourHex = selectedCategory?.colour{
//            
//            guard let navBar = navigationController?.navigationBar else {
//                fatalError("Navigation controller not exist.")
//            }
//            
//            navigationController?.navigationBar.barTintColor = UIColor(hexString: colourHex)
//        }
        //searchBar.delegate = self
        // Do any additional setup after loading the view.
        //        if let items =  defaults.array(forKey: "TodoListArray")as? [Item]{
        //            itemArray = items
        //        }
        // let request: NSFetchRequest<Item> = Item.fetchRequest()
        //loadItems()
   
       
    }
    
    //MARK: - Tableview data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("cellforRowAtIndexPath Call")
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            if let colour = FlatWhite().darken(byPercentage:CGFloat(indexPath.row)/CGFloat(todoItems!.count)){
                cell.backgroundColor = colour
                cell.textLabel?.textColor
                = ContrastColorOf(colour, returnFlat: true)
            }
            
            
                                                    
//            cell.backgroundColor = FlatSkyBlue().darken(byPercentage: CGFloat(indexPath.row/todoItems?.count)
            
            cell.accessoryType = item.done  ? .checkmark: .none
        }else{
            cell.textLabel?.text = "Np items added"
        }
        
        return cell
    }
    
    //MARK: - TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write{
                    //realm.delete(item)
                    item.done = !item.done
                }
            }catch{
                print("Error savibng done status, \(error)")
            }
            tableView.reloadData()
        }
        // print(itemArray[indexPath.row])
        
        //itemArray[indexPath.row].setValue("Completed", forKey: "title")
        
        //        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        //
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        
        //saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        //
        //        if tableView.cellForRow(at: indexPath)?.accessoryType  == .checkmark{
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //        }else{
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //        }
        
        
    }
    //MARK: - add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the add item button on our UIAlert
            //print(textField.text)
            
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Error saving new items, \(error)")
                }
            }
            
            self.tableView.reloadData()
            //newItem.done = false
            //            newItem.parentCategory = self.selectedCategory
            //            self.itemArray.append(newItem)
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            //self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK: - Model manipulation methods
    //    func saveItems(){
    //       // let encoder = PropertyListEncoder()
    //        do{
    //            try context.save()
    //            //let data = try encoder.encode(itemArray)
    ////            try data.write(to: dataFilePath!)
    //        }catch{
    //           print("Error saving context,\(error)")
    //        }
    //        self.tableView.reloadData()
    //    }
    
    func loadItems(){
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        //        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        //
        //        if let additionalPredicate = predicate {
        //            request.predicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        //        }else{
        //            request.predicate = categoryPredicate
        //        }
        
        //        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
        //
        //        request.predicate = compoundPredicate
        
        //let request: NSFetchRequest<Item> = Item.fetchRequest()
        //        do{
        //            itemArray = try context.fetch(request)
        //        }catch{
        //            print("Error fetching data from context \(error)")
        //        }
        tableView.reloadData()
        //        if let data = try? Data(contentsOf: dataFilePath!){
        //            let decoder = PropertyListDecoder()
        //            do{
        //                itemArray = try decoder.decode([Item].self, from: data)
        //            }catch{
        //                print("Error decoding items,\(error)")
        //            }
        //        }
        //   }
        
    }
    override func updateModel(at indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row]{
            do{
                try self.realm.write{
                    self.realm.delete(item)
                }
            }catch{
                print("Error deleting item,\(error)")
            }
        }
    }
}
    //MARK: - Search bar method
extension ToDoListViewController: UISearchBarDelegate{
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated" , ascending: true)
            
            tableView.reloadData()
            
            //            let request: NSFetchRequest<Item> = Item.fetchRequest()
            //            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
            //
            //
            //            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            //            loadItems(with: request,predicate: predicate)
            
            
            //        do{
            //            itemArray = try context.fetch(request)
            //        }catch{
            //            print("Error fetching data from context \(error)")
            //        }
            //       tableView.reloadData()
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            if searchBar.text?.count == 0{
                loadItems()
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }
                
            }
        }
    }
    

