//
//  Category.swift
//  Todoey
//
//  Created by Shazeen Thowfeek on 17/10/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    //@objc dynamic var colour: String = ""
    
    //creating relationship
    let items = List<Item>()
    
    
    
}

