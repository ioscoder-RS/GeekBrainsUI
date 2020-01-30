//
//  CommonRepository.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 29/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//


import RealmSwift

class CommonRepository {
    
    func getAllfromTable<T: Object> (vkObject: VKObjects) throws -> Results<T>{
        var object:Object.Type
        var tmpdefault:Results<Object>
     
        
         let realm = try Realm()
        
       
        
            switch vkObject{
            case .VKGroup:
                object = VKGroupRealm.self
            case .VKPhoto:
                object = VKPhotoRealm.self
            case .VKUser:
               object = VKUserRealm.self
            }//switch
     //   tmpdefault = realm.objects(object.self).filter("FALSEPREDICATE")
        //MARK: падает при повторном вызове после search
        return realm.objects(object) as! Results<T> 
            //as? Results<T> ?? tmpdefault
    }//func getAllfromTable
   
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
    
} //class CommonRepository

