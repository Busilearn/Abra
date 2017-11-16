//
//  OlohApiClient.swift
//  Oloh
//
//  Created by Baptiste Jacob on 10/28/17.
//  Copyright © 2017 oloh. All rights reserved.
//


import Foundation
import RealmSwift


class OlohApiClient {

    
    let realm = try! Realm()
    var category: Results<Category>?
    var product: Results<Products>?
    
    init() {
        
        self.category = self.realm.objects(Category.self)
        self.product = self.realm.objects(Products.self)
        
        print(realm.configuration.fileURL ?? "")
        
        FetchData.get(type: Category.self , success: {
            print(self.category!.description)
        }) { (error) in
            print("error")
        }
        
        FetchData.get(type: Products.self , success: {
            print(self.product!.description)
        }) { (error) in
            print("error")
        }
        
    }
}
