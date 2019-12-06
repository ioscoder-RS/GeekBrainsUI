//
//  Group_vk.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 02/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit

class VK_Group
    //взято с https://vk.com/dev/objects/group
{
    var id:Int //идентификатор сообщества.
    var name:String //   название сообщества.
    var screen_name:String // короткий адрес, например, apiclub.
    var is_closed:Int // является ли сообщество закрытым. Возможные значения:
//    0 — открытое;
//    1 — закрытое;
//    2 — частное.
    var deactivated:String //возвращается в случае, если сообщество удалено или заблокировано. Возможные значения:
//     deleted — сообщество удалено;
//     banned — сообщество заблокировано;
    var is_admin:Int // [0, 1]
//    1 — является;
//    0 — не является.
    var admin_level:Int //Требуется scope = groups    уровень полномочий текущего пользователя (если is_admin = 1):
//    1 — модератор;
//    2 — редактор;
//    3 — администратор.
    var is_member: Int
// Возможные значения:
//    1 — является;
//    0 — не является.
    
// Есть еще переменные, штук 10... при необходимости добавить!
    
    init(id:Int,name:String,screen_name:String,is_closed:Int,deactivated:String,is_admin:Int,admin_level:Int,is_member: Int){
        self.id = id
        self.name = name
        self.screen_name = screen_name
        self.is_closed = is_closed
        self.deactivated = deactivated
        self.is_admin = is_admin
        self.admin_level = admin_level
        self.is_member = is_member
        
        return
    }//init
}//class
