//
//  VKPhotosRealm.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 29/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import RealmSwift

class VKPhotosRealm: Object {
    @objc dynamic var id = 0
    let sizes = List<String>()
    @objc dynamic var albumID = 0
     @objc dynamic var ownerID = 0
      @objc dynamic var text = ""
       @objc dynamic var date = 0
     @objc dynamic var postID = 0
    
//     let likes: Likes?
//     let reposts: Reposts?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func toModel() -> VKPhoto {
        return VKPhoto(id: id, albumID: albumID, ownerID: ownerID, sizes: [] , text: text, date: date, postID: postID, likes: nil, reposts: nil, lat: 0, long: 0)
    }
    
}//class VKUserRealm
