//
//  Cart.swift
//  Oloh
//
//  Created by mickael on 20/11/2017.
//  Copyright © 2017 oloh. All rights reserved.
//

import Foundation
import RealmSwift


class Cart {
    // Get the default Realm
    static let realm = try! Realm()
    
    static func addToCart(productCart:ProductCart) -> String? {
        var qty = "0"
        try! realm.write {
            realm.add(productCart, update: true)
            productCart.qty += 1
            qty =  String(productCart.qty)
        }
        return qty
    }
    
    
    static func remFromCart(productCart:ProductCart) -> String? {
        var qty = "0"
        if productCart.qty >= 0{
            try! realm.write {
                productCart.qty -= 1
                qty = String(productCart.qty)
                if productCart.qty == 0 {
                    realm.delete(productCart)
                }
            }
            
        }
        return qty
    }
    
}
