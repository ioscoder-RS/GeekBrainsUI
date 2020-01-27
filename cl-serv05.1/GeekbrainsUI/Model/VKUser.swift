//
//  VKUser.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 19/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//



// MARK: - Response
struct VKUser: Codable {
    var lastName:String
    var firstName:String
    var avatarPath:String
    var isOnline:Int
    var id:Int
    
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
        case avatarPath = "photo_50"
        case isOnline = "online"
        case id
        
    }
}

struct UserResponse: Codable {
    let response: UserResponseData
}

// MARK: - Welcome
struct UserResponseData: Codable {
    let count: Int
    let items: [VKUser]
}

var webVKUsers = [VKUser]()

         func getFriends(users: [VKUser]) -> [Friend]{
            //Функция имеет два назначения:
                  //1. Сохранить данные пришедшие из Web в экземпляре структуры
                  //2. Преобразовать модель данных из web-запроса в нужную нам модель для отображения
            var myFriends = [Friend]()
    
            for a in 0...users.count-1 {
                myFriends.append(Friend(userName: users[a].firstName + " " + users[a].lastName, avatarPath: users[a].avatarPath, isOnline: users[a].isOnline, id: users[a].id))
            }
            return myFriends
        }

