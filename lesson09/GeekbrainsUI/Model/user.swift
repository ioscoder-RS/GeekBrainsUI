//
//  user.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 02/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit

class VKUser{
    //взят с https://vk.com/dev/objects/user
    
    var id: Int //    идентификатор пользователя.
    var firstName: String  //  имя.
    var lastName: String    //фамилия.
    var deactivated: String  //  поле возвращается, если страница пользователя удалена или заблокирована, содержит значение deleted или banned. В этом случае опциональные поля не возвращаются.
    var isClosed: Bool //    скрыт ли профиль пользователя настройками приватности.
    var canAccessClosed: Bool //может ли текущий пользователь видеть профиль при isClosed = 1 (например, он есть в друзьях).
    
    init(id:Int,firstName:String,lastName:String,deactivated:String,isClosed:Bool,canAccessClosed: Bool){
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.deactivated = deactivated
        self.isClosed = isClosed
        self.canAccessClosed = canAccessClosed
        
        return
    }
}
