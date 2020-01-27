//
//  VKPhotoRealm.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 22/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import Foundation
import RealmSwift

 
class VKPhotoRealm: Object {
    @objc dynamic var id = 0
    let sizes = List<String>()
    @objc dynamic var albumID = 0
     @objc dynamic var ownerID = 0
      @objc dynamic var text = ""
       @objc dynamic var date = 0
    //To BE - реализовать опционал
//    let albumID = RealmOptional<Int>()
//    let ownerID = RealmOptional<Int>()
//    let text = RealmOptional<String>()
//    let date = RealmOptional<Int>()


    var VKPhotoList = List<VKPhotoRealm>()
}
