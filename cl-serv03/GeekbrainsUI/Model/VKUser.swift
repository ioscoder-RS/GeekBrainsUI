//
//  VKUser.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 19/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//



// MARK: - Response
struct VKUser: Codable {
     var userName:String
     var avatarPath:String
     var isOnline:Int
     var id:Int
     var photoArray:[String]?
    
    enum CodingKeys: String, CodingKey {
        case userName = "last_name"
        case avatarPath = "photo_50"
        case isOnline = "online"
        case id
        case photoArray
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

var myVKUser: [VKUser] = [VKUser(userName: "", avatarPath: "", isOnline: 0, id: 0, photoArray:[])]
