//
//  GroupRepository.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 29/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import RealmSwift

class GroupRepository {
    
    var localCommonRepository = CommonRepository()
    
    func getAllGroups() throws -> Results<VKGroupRealm>{
        do {
            return try localCommonRepository.getAllfromTable(vkObject: .VKGroup) as Results<VKGroupRealm>
        } catch {
            throw error
        }
    }//func getAllUsers
    
    func addGroups (groups:[VKGroup]) {
        do {
            let realm = try Realm()
            try realm.write {
                var groupsToAdd = [VKGroupRealm]()
                groups.forEach{
                    group in
                    let groupRealm = VKGroupRealm()
                    groupRealm.id = group.id
                    groupRealm.groupName = group.groupName
                    groupRealm.avatarPath = group.avatarPath
                    groupsToAdd.append(groupRealm)
                }//groups.forEach
                realm.add(groupsToAdd, update: .modified)
            }//realm.write
            print(realm.objects(VKGroupRealm.self))
        }catch{
            print(error)
        }
}// func addGroups
    
}//class class GroupRepository
