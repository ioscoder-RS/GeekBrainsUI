//
//  VKWorkWithDBRealm.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 22/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import Foundation
import RealmSwift

enum VKObjects{
    case VKUser
    case VKGroup
    case VKPhoto
}

class VKWorkWithDBRealm {
    // MARK: - Deletion
    func deleteVKObject(object: VKObjects){
        let realm = try! Realm()
        
        switch object{
        case .VKUser:
            try! realm.write {
                return realm.delete(realm.objects(VKUserRealm.self))
            }
        case .VKGroup:
            try! realm.write {
                return realm.delete(realm.objects(VKGroupRealm.self))
            }
        case .VKPhoto:
            try! realm.write {
                return realm.delete(realm.objects(VKPhotoRealm.self))
            }
        }//switch object
    }//deleteVKObject(object: VKObjects)
    
    // MARK: - User
    func addUser(id:Int, lastName:String, firstName:String, avatarPath:String, isOnline:Int) {
        let realm = try! Realm()
        let newUser = VKUserRealm()
        newUser.id = id
        newUser.lastName = lastName
        newUser.firstName = firstName
        newUser.avatarPath = avatarPath
        newUser.isOnline = isOnline
        
        
        try! realm.write {
            realm.add(newUser)
        }
    }// func addUser
    
    func getUsers() -> Results<VKUserRealm> {
        let realm = try! Realm()
        return realm.objects(VKUserRealm.self)
    }
    
    func getUser(id:Int, lastName: String?, avatarPath: String?) -> VKUserRealm? {
        
        var filter: String
        let realm = try! Realm()
        
        if id != 0 {
            filter = "id == %@"
            return realm.objects(VKUserRealm.self).filter(filter, id).first
        } else
        {
            guard let localavatarPath = avatarPath else {return nil}
            filter = "avatarPath == %@"
            return realm.objects(VKUserRealm.self).filter(filter, localavatarPath).first
        }
    }
    
    
    
    // MARK: - Group
    
    func addGroup(id:Int, groupName:String, avatarPath:String) {
        let realm = try! Realm()
        let newGroup = VKGroupRealm()
        newGroup.id = id
        newGroup.groupName = groupName
        newGroup.avatarPath = avatarPath
        
        try! realm.write {
            realm.add(newGroup)
        }
    }// func addGroup
    
    func getGroups() -> Results<VKGroupRealm> {
        let realm = try! Realm()
        return realm.objects(VKGroupRealm.self)
    }
    
    func getGroup(id:Int?, groupName: String?, avatarPath: String?) -> VKGroupRealm? {
        
        var filter: String
        let realm = try! Realm()
        
        // ф-ция возвращает группу по любому из трех параметров на входе
        if let localID = id {
            //`если заполнен id фильтруем по нему
            filter = "id == %@"
            return realm.objects(VKGroupRealm.self).filter(filter, localID).first
        }else{
            if let localGroupName = groupName{
                //`если заполнен groupName фильтруем по нему
                filter = "groupName == %@"
                return realm.objects(VKGroupRealm.self).filter(filter, localGroupName).first
            } else
            {
                if let localAvatarPath = avatarPath{
                    //`если заполнен avatarPath фильтруем по нему
                    filter =  "avatarPath == %@"
                    return realm.objects(VKGroupRealm.self).filter(filter, localAvatarPath).first
                    
                }
                else {return nil} //ни один из параметров не заполнен
            }//else #2
        }//else #1 if let localID = id
    }//func getGroup
    
    // MARK: - Photo
    func addPhoto( id: Int, albumID: Int, ownerID: Int, sizes: [String],
                   text: String, date: Int)
    {
        var realm2 = try! Realm()
        let newPhoto = VKPhotoRealm()
        
        newPhoto.id = id
        newPhoto.albumID = albumID
        newPhoto.ownerID = ownerID
        newPhoto.sizes.append(objectsIn: sizes)
        newPhoto.text = text
        newPhoto.date = date
        
        try! realm2.write {
            realm2.add(newPhoto)
        }
        
    }// func addPhoto
    
    func getPhotos() -> Results<VKPhotoRealm> {
        let realm = try! Realm()
        return realm.objects(VKPhotoRealm.self)
    }
    
}//class VKWorkWithDBRealm
