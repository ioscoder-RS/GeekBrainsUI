//
//  user.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 02/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit

class VK_User{
    //взят с https://vk.com/dev/objects/user
    
    var id: Int //    идентификатор пользователя.
    var first_name: String  //  имя.
    var last_name: String    //фамилия.
    var deactivated: String  //  поле возвращается, если страница пользователя удалена или заблокирована, содержит значение deleted или banned. В этом случае опциональные поля не возвращаются.
    var is_closed: Bool //    скрыт ли профиль пользователя настройками приватности.
    var can_access_closed: Bool //может ли текущий пользователь видеть профиль при is_closed = 1 (например, он есть в друзьях).
    
    init(id:Int,first_name:String,last_name:String,deactivated:String,is_closed:Bool,can_access_closed: Bool){
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.deactivated = deactivated
        self.is_closed = is_closed
        self.can_access_closed = can_access_closed
        
        return
    }
}
