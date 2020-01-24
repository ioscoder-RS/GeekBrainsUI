//
//  VKUserRealm.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 22/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import Foundation
import RealmSwift

 
class VKUserRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var lastName = ""
    @objc dynamic var firstName = ""
    @objc dynamic var avatarPath = ""
    @objc dynamic var isOnline = 0
    
    
    var VKUserList = List<VKUserRealm>()
}




