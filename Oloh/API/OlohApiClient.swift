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
    var categories: Results<Category>?
    var products: Results<Products>?
    var notificationToken: NotificationToken?

    init() {
        
        self.categories = self.realm.objects(Category.self)
        self.products = self.realm.objects(Products.self)
        
        print(realm.configuration.fileURL ?? "")
        
        FetchData.get(type: Category.self , success: {
//            print(self.category!.description)
        }) { (error) in
            print("error")
        }
        
        FetchData.get(type: Products.self , success: {
//            print(self.product!.description)
        }) { (error) in
            print("error")
        }
        
        
        notificationToken = realm.observe { notification, realm in
            print("majAPI")
            for product in products! {
//                try realm.write {
                    product.category = realm.objects(Category.self).filter("color = 'tan' AND name BEGINSWITH 'B'")

//                }
            }
            
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}
