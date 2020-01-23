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
    [Friend(userName: "Николай Астафьев", avatarPath:"UserOne", isOnline:false),
     Friend(userName:"Олег Васильев", avatarPath:"AserTwo", isOnline:false),
     Friend(userName:"Антон Михайлов", avatarPath:"UserTwo", isOnline:false),
     Friend(userName:"Сергей Воронин", avatarPath:"AserFour", isOnline:false),
     Friend(userName:"Александр Дятлов", avatarPath:"BserThree", isOnline:false),
     Friend(userName:"Алексей Елкин", avatarPath:"DserFour", isOnline:false),
     Friend(userName:"Дмитрий Миронов", avatarPath:"UserThree", isOnline:false),
     Friend(userName:"Павел Зонтиченко", avatarPath:"CserFour", isOnline:false)
]
