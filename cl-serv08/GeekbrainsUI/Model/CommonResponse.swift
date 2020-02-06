//
//  CommonResponse.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 24/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import Foundation
import UIKit

struct CommonResponse<T: Decodable>: Decodable {
    var response: CommonResponseArray<T>
}

struct CommonResponseArray<T: Decodable>: Decodable{
    var count: Int
    var items: [T]
}

enum DatabaseType {
    case Realm
    case CoreData
}

 typealias Out = Swift.Result

 var databaseMode = true //флаг пишем ли в БД или только с Web работаем
 var webMode = false //флаг работаем офлайн или с обращением к интернету

func showYesNoMessage(view: UIViewController, title: String, messagetext: String, completion:@escaping (_ result:Bool) -> Void) {

    // Создаем контроллер
    let alert = UIAlertController(title: title, message: messagetext, preferredStyle: .alert)
    // Создаем кнопку для UIAlertController
    let action = UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
        completion(false)
    })
     alert.addAction(action)
    
    let action2 = UIAlertAction(title: "Delete", style: .destructive, handler: {action in
        completion(true)
        
    })
    alert.addAction(action2)
    // Показываем UIAlertController
    view.present(alert, animated: true, completion: nil )
    
}


