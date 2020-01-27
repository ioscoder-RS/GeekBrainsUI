//
//  VKGroupRealm.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 22/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import Foundation
import RealmSwift

class VKGroupRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var groupName = ""
    @objc dynamic var avatarPath = ""

    var VKGroupList = List<VKGroupRealm>()
}
