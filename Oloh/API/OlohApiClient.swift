//
//  OlohApiClient.swift
//  Oloh
//
//  Created by Baptiste Jacob on 10/28/17.
//  Copyright © 2017 oloh. All rights reserved.
//


import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RealmSwift


class OlohApiClient {
    let headers: HTTPHeaders
    let olohUrl: String
    
    init() {
        // setting url and route
        self.olohUrl = "https://oloh.fr"
        
        // generating token for basic auth
        let user = "ck_fb2a39bf26ad4535b96a3d4e3a518e9378825148"
        let password = "cs_3709ea5013a44e175a5079bd67204f092a4a2d5e"
        
        let utf8str = "\(user):\(password)".data(using: String.Encoding.utf8)
        let token = utf8str!.base64EncodedString()
        
        // setting up headers
        self.headers = [
            "Authorization": "Basic \(token)",
            "Accept": "application/json"
        ]
    }
    
    func syncAllCategories() {
        Alamofire.request(
            "\(self.olohUrl)/wp-json/wc/v2/products/categories?per_page=100",
            headers: headers
            ).responseJSON { (response) -> Void in
                
                if let JSON = response.result.value as! [[String: Any]]? {
                    for elem in JSON {
                        let newCategory = Category()
//                      print("\(elem["image"])")
                        newCategory.id.value = elem["id"] as? Int
                        newCategory.parent.value = elem["parent"] as? Int
                        newCategory.categoryName = elem["name"] as? String
                        newCategory.categoryDescription = elem["description"] as? String
                        newCategory.categoryImageUrl = "/tmp"
                        newCategory.writeToRealm()
//                        print("\(newCategory.categoryName ?? "")")
                    }
                }
        }
    }
    
    func syncAllProducts() {
        Alamofire.request(
            "\(self.olohUrl)/wp-json/wc/v2/products?per_page=100",
            headers: headers
            ).responseJSON { (response) -> Void in
                
                if let JSON = response.result.value as! [[String: Any]]? {
                    for elem in JSON {
                        let newProduct = Product()
                        newProduct.id.value = elem["id"] as? Int
                        newProduct.name = elem["name"] as? String
//                        Expression régulière pour échaper les balises html
                        let prodDescBrut = elem["description"] as? String
                        newProduct.productDescription = prodDescBrut?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                        newProduct.price = elem["price"] as? String
                        newProduct.average_rating = elem["average_rating"] as? String
                        newProduct.rating_count = elem["rating_count"] as? String
//                        Expression régulière pour échaper les balises html
                        let prodShortDescBrut = elem["description"] as? String
                        newProduct.short_description = prodShortDescBrut?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                        newProduct.catalog_visibility = elem["catalog_visibility"] as? String
                        newProduct.status = elem["status"] as? String
                        newProduct.sku = elem["sku"] as? String
                        newProduct.imageUrl = "/tmp"
                        newProduct.stock_quantity = elem["stock_quantity"] as? String
                        newProduct.in_stock = (elem["in_stock"] as? Bool)!

                        newProduct.writeToRealm()
//                        print("\(newProduct.name!)")
                    }
                }
        }
    }
    
}
