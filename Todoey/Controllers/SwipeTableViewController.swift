//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Shazeen Thowfeek on 17/10/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController,SwipeTableViewCellDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
    }
    
    //Tableview datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            //print("Item deleted")
            
            //print("delete cell")
            self.updateModel(at: indexPath)
            
            //            if let categoryForDeletion = self.categories?[indexPath.row]{
            //                do{
            //                    try self.realm.write{
            //                        self.realm.delete(categoryForDeletion)
            //                    }
            //                }catch{
            //                    print("Error deleting category,\(error)")
            //                }
            //               // tableView.reloadData()
            //            }
            //        }
        }
            // customize the action appearance
            deleteAction.image = UIImage(named: "delete-icon")
            
            return [deleteAction]
        }
        func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
            var options = SwipeOptions()
            options.expansionStyle = .destructive
            //options.transitionStyle = .border
            return options
        }
    func updateModel(at indexPath: IndexPath){
        
    }
        
    }
    
    

