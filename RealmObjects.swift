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
}

extension Category {
    func writeToRealm() {
        try! uiRealm.write {
            uiRealm.add(self)
        }
    }
}
