//
//  OlohApiClient.swift
//  Oloh
//
//  Created by Baptiste Jacob on 10/28/17.
//  Copyright © 2017 oloh. All rights reserved.
//

import Foundation
import Alamofire

class OlohApiClient {
    let headers: HTTPHeaders
    let olohUrl: String
    let categories: String
    
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
    
    func getAllCategories() {
        Alamofire.request(
            "\(self.olohUrl)/wp-json/wc/v2/products/categories?per_page=100",
            headers: headers
            ).responseJSON { response in
                if let res = response.result.value {
                    print("JSON: \(res)")
                }
        }
    }
}
