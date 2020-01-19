//
//  Friend.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 08/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
import Foundation



/****
прошлая версия. Заполнение не из vk.com
 *****/

struct Friend{
    var userName:String
    var avatarPath:String
    var isOnline:Int
    var id:Int
    var photoArray:[String]
}


var myFriends: [Friend] =
    [Friend(userName: "Мария Берсенева", avatarPath:"berseneva1", isOnline:0, id:1, photoArray:["berseneva1","berseneva2","berseneva3"]),
     Friend(userName:"Анастасия Стежко", avatarPath:"stezhko1", isOnline:0, id:2, photoArray:["stezhko1","stezhko2","stezhko3"]),
     Friend(userName:"Сергей Афанасьев", avatarPath:"sergei afanasiev1", isOnline:0, id:3, photoArray:["sergei afanasiev1","sergei afanasiev2"]),
     Friend(userName:"Николай Рассказов", avatarPath:"NikolayRasskazov1", isOnline:0, id:4, photoArray:["NikolayRasskazov1","NikolayRasskazov2"]),
     Friend(userName:"Лаутаро Мартинес", avatarPath:"lautaro martinez1", isOnline:0, id:5, photoArray:["lautaro martinez1","lautaro martinez2","lautaro martinez3"]),
     Friend(userName:"Алексей Елкин", avatarPath:"DserFour", isOnline:0, id:6, photoArray:["1"]),
     Friend(userName:"Дмитрий Миронов", avatarPath:"UserThree", isOnline:0, id:7, photoArray:["1"]),
     Friend(userName:"Павел Зонтиченко", avatarPath:"CserFour", isOnline:0, id:8, photoArray:["1"])
]

