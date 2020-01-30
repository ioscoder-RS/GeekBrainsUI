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

    
        

    
    
    
    // MARK: - Group
    

    
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
