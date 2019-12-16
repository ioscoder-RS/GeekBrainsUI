//
//  Group_vk.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 02/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit

class VKGroup
    //взято с https://vk.com/dev/objects/group
{
    var id:Int //идентификатор сообщества.
    var name:String //   название сообщества.
    var screenName:String // короткий адрес, например, apiclub.
    var isClosed:Int // является ли сообщество закрытым. Возможные значения:
//    0 — открытое;
//    1 — закрытое;
//    2 — частное.
    var deactivated:String //возвращается в случае, если сообщество удалено или заблокировано. Возможные значения:
//     deleted — сообщество удалено;
//     banned — сообщество заблокировано;
    var isAdmin:Int // [0, 1]
//    1 — является;
//    0 — не является.
    var adminLevel:Int //Требуется scope = groups    уровень полномочий текущего пользователя (если is_admin = 1):
//    1 — модератор;
//    2 — редактор;
//    3 — администратор.
    var isMember: Int
// Возможные значения:
//    1 — является;
//    0 — не является.
    
// Есть еще переменные, штук 10... при необходимости добавить!
    
    init(id:Int,name:String,screenName:String,isClosed:Int,deactivated:String,isAdmin:Int,adminLevel:Int,isMember: Int){
        self.id = id
        self.name = name
        self.screenName = screenName
        self.isClosed = isClosed
        self.deactivated = deactivated
        self.isAdmin = isAdmin
        self.adminLevel = adminLevel
        self.isMember = isMember
        
        return
    }//init
}//class
