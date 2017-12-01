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


class Category:Object,Mappable,Meta {
    
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

class Products:Object,Mappable,Meta {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var productDescription = ""
    @objc dynamic var price = ""
    @objc dynamic var average_rating = ""
    @objc dynamic var rating_count = 0
    //    private RealmList<Images> images; TODO
    @objc dynamic var short_description = ""
    @objc dynamic var catalog_visibility = ""
    @objc dynamic var status = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var stock_quantity = 0
    @objc dynamic var in_stock = false
    var category = List<Category>()
    
    
    override static func primaryKey()-> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        
        id <- map["id"]
        name <- map["name"]
        productDescription <- map["description"]
        productDescription = productDescription.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        price <- map["price"]
        average_rating <- map["average_rating"]
        rating_count <- map["rating_count"]
        short_description <- map["short_description"]
        short_description = short_description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        catalog_visibility <- map["catalog_visibility"]
        status <- map["status"]
        imageUrl <- map["images.0.src"]
        stock_quantity <- map["stock_quantity"]
        in_stock <- map["in_stock"]
        category <- map["categories.0.id"]
        
        
    }
    
    static func url() -> String {
        return "https://oloh.fr/wp-json/wc/v2/products?per_page=100"
    }
}


class ProductCart:Object {
    @objc dynamic var id = 0
    @objc dynamic var qty = 0
    @objc dynamic var products: Products?

    override class func primaryKey() -> String? {
        return "id"
    }
    
}
