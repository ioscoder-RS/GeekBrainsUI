//
//  FriendsToDatabase.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 27/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import Foundation

protocol FriendListPresenter{
    //  func getFriendList(completion: @escaping (Swift.Result<[VKUser],Error>)->())
    func getFriendsFromDatabase() ->[VKUser]
}

class FriendListPresenterImplementation: FriendListPresenter{
    
    
    let vkAPI: VKAPi
    let database: FriendCoreDataRepository
    
    
    init(database: FriendCoreDataRepository, api: VKAPi){
        self.vkAPI = api
        self.database = database
    }
    
    func saveFriendListtoDB (usersToSave: [VKUser], completion: @escaping (Swift.Result<[VKUser], Error>) -> ())
    {
        usersToSave.forEach { self.database.create(entity: $0)}; completion(.success(usersToSave))
    }
    
    func getFriendsFromDatabase() -> [VKUser] {
        return database.getAll()
    }
}//class riendListPresenterImplementation
