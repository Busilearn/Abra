//
//  RealmObjects.swift
//  Oloh
//
//  Created by Baptiste Jacob on 11/7/17.
//  Copyright © 2017 oloh. All rights reserved.
//

import Foundation
import RealmSwift


class Category : Object {
    var id = RealmOptional<Int>()
    var parent = RealmOptional<Int>()
    @objc dynamic var categoryName : String? = nil
    @objc dynamic var categoryDescription : String? = nil
    @objc dynamic var categoryImageUrl : String? = nil
}

extension Category {
    func writeToRealm() {
        try! uiRealm.write {
            uiRealm.add(self)
        }
    }
}

class Product : Object {
    var id = RealmOptional<Int>()
    @objc dynamic var name : String? = nil
    @objc dynamic var productDescription : String? = nil
    @objc dynamic var price : String? = nil
    @objc dynamic var average_rating : String? = nil
    @objc dynamic var rating_count : String? = nil
//    private RealmList<Images> images; TODO
    @objc dynamic var short_description : String? = nil
    @objc dynamic var catalog_visibility : String? = nil
    @objc dynamic var status : String? = nil
    @objc dynamic var sku : String? = nil
    @objc dynamic var imageUrl : String? = nil
    @objc dynamic var stock_quantity : String? = nil
//    @objc dynamic var in_stock : Boolean? = nil
//    @objc dynamic var categories : Category? = nil
}

extension Product {
    func writeToRealm() {
        try! uiRealm.write {
            uiRealm.add(self)
        }
    }
}
