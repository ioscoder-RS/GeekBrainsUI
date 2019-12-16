//
//  Friend.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 08/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
import Foundation

struct Friend{
    var userName:String
    var avatarPath:String
    var isOnline:Bool
}

var myFriends: [Friend] = 
                  [Friend(userName:"UserOne", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"AserTwo", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"UserTwo", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"AserFour", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"BserThree", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"DserFour", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"UserThree", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"CserFour", avatarPath:"NewUser", isOnline:false)
]
