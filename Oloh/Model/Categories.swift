//
//  Categories.swift
//  Oloh
//
//  Created by mickael on 15/11/2017.
//  Copyright © 2017 oloh. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

protocol Meta {
    static func url()->String
}


class Categories:Object,Mappable,Meta {
    
    @objc dynamic var id = 0
    @objc dynamic var parent = 0 
    @objc dynamic var categoryName = ""
    @objc dynamic var categoryDescription = ""
    @objc dynamic var image = ""

    
    override static func primaryKey()-> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        parent <- map["parent"]
        categoryName <- map["name"]
        categoryDescription <- map["description"]
        image <- map["image.src"]

    }
    
    static func url() -> String {
        return "https://oloh.fr/wp-json/wc/v2/products/categories?per_page=100"
    }
    
    
}
