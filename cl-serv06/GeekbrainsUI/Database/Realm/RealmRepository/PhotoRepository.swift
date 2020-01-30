//
//  PhotoRepository.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 29/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import RealmSwift

class PhotoRepository {
    
    var localCommonRepository = CommonRepository()
    
    func getAllPhotos() throws -> Results<VKPhotosRealm>{
        do {
            return try (localCommonRepository.getAllfromTable(vkObject: .VKPhoto) as? Results<VKPhotosRealm>)!
        } catch {
            throw error
        }
    }//func getAllPhotos
    
    func addPhotos (photos:[VKPhoto]) {
        do {
            let realm = try Realm()
            try realm.write {
                var photosToAdd = [VKPhotosRealm]()
                photos.forEach{
                    photo in
                    let photosRealm = VKPhotosRealm()
                    photosRealm.id = photo.id
                    photosRealm.sizes.append("1")
    //                photosRealm.sizes = photo.sizes
                    photosRealm.albumID = photo.albumID
                    photosRealm.ownerID = photo.ownerID
                    photosRealm.text = photo.text
   //                 photosRealm.date = photo.date
   //                 photosRealm.postID = photo.postID
                    photosToAdd.append(photosRealm)
                }//groups.forEach
                realm.add(photosToAdd, update: .modified)
            }//realm.write
            print(realm.objects(VKPhotosRealm.self))
        }catch{
            print(error)
        }
}// func addGroups
    
}//class class GroupRepository
