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
    @objc dynamic var slug : String? = nil
    var menu_order : NSInteger? = nil
    var category_description : String? = nil
    var image : Any? = nil
    var count : NSInteger? = nil
    var parent : NSInteger? = nil
    var id : NSInteger? = nil
    var display: String? = nil
    var category_name : String? = nil
}

extension Category {
    func writeToRealm() {
        try! uiRealm.write {
            uiRealm.add(self)
        }
    }
}
