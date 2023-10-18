//
//  Item.swift
//  Todoey
//
//  Created by Shazeen Thowfeek on 17/10/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date? 
    
    // inverse relationship to link to parent 
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
