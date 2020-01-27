//
//  UserRealm.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 21/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import Foundation
import RealmSwift

class UserRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var username = ""
    @objc dynamic var surname = ""
    
    var group = List<GroupRealm>()
}

class GroupRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
}

class UserRepositoryRealm {
    func addUser(username: String, surname: String) {
        let realm = try! Realm()
        let newUser = UserRealm()
        newUser.id = 1
        newUser.surname = surname
        newUser.username = username
        
        try! realm.write {
            realm.add(newUser)
        }
    }// func addUser
    
    func getUsers() -> Results<UserRealm> {
         let realm = try! Realm()
         return realm.objects(UserRealm.self)
     }
    
    func getUser(id:Int) -> UserRealm? {
        let realm = try! Realm()
        return realm.objects(UserRealm.self).filter("id == %@", id).first
    }
}//class UserRepositoryRealm

