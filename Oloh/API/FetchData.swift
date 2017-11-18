//
//  FetchData.swift
//  Oloh
//
//  Created by mickael on 15/11/2017.
//  Copyright © 2017 oloh. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RealmSwift

class FetchData {

    static func get <T: Object> (type: T.Type, success:() -> Void, fail:@escaping (_ error:NSError)->Void)->Void where T:Mappable, T:Meta {

        let utf8str = "\(Constants.user):\(Constants.password)".data(using: String.Encoding.utf8)
        let token = utf8str!.base64EncodedString()
        
        // setting up headers
        let headers: HTTPHeaders

        headers = [
            "Authorization": "Basic \(token)",
            "Accept": "application/json"
        ]
        
        Alamofire.request(type.url(),headers: headers).responseArray { (response: DataResponse<[T]>) in
            switch response.result {
            case .success(let items):
                DispatchQueue(label: "background").async {

                    autoreleasepool {
                        do {
                            let realm = try Realm()
                            try realm.write {
                                for item in items {
    //                                print(item)
                                    realm.add(item, update: true)
                                }
                            }
                        } catch let error as NSError {
                            fail(error)
                        }
                    }
                }
            case .failure(let error):
                fail(error as NSError)
            }
        }
        
    }
}
