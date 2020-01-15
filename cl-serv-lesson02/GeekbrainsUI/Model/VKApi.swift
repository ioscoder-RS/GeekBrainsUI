//
//  VKApi.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 15/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import WebKit
import Alamofire

class VKAPi {
let vkURL = "https://api.vk.com/method/"
    
    //Получение списка друзей
    func getFriendList(token: String)  {
        let requestURL = vkURL + "friends.get"
        let params = ["v": "5.103",
                      "access_token":token,
                      "order":"name",
                      "fields":"city,domain"]
   
   
        Alamofire.request(requestURL,
                          method: .post,
            parameters: params).responseString(completionHandler: { (response) in
                print("\nПолучение списка друзей "+response.value!)
            })

    }//func getFriendList
    
    //Получение фотографий человека
    func getPhotosList(token: String, userId: String){
        let requestURL = vkURL + "photos.get"
        let params = ["v": "5.103",
                      "access_token":token,
                      "owner_id":userId,
                      "album_id":"wall"
        ]
        
        
        Alamofire.request(requestURL,
                          method: .post,
            parameters: params).responseJSON(completionHandler: { (response) in
                (print("\n Получение фотографий человека"), print( response.value!))
            })
    }//func getPhotosList
    
    //Получение групп текущего пользователя
    func getGroupsList(token: String, userId: String){
        let requestURL = vkURL + "groups.get"
        let params = ["v": "5.103",
                      "access_token":token,
                      "user_id":userId,
                      "extended":"1"
        ]
   
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseJSON(completionHandler: { (response) in
            (print("\nПолучение групп текущего пользователя"),print(response.value!))          })
    }//func getGroupsList
    
    //Получение групп по поисковому запросу;
    func searchGroups (token: String, query: String){
        let requestURL = vkURL + "groups.search"
        let params = ["v": "5.103",
                      "access_token":token,
                      "q":query,
                      "type":"group",
                      "count":"3",
                      "country_id":"1" //Россия
        ]
    

        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseJSON(completionHandler: { (response) in
                               (print("\nПолучение групп по поисковому запросу \(query)"),print(response.value!))
                     })
    }//func searchGroups
    
}//class VKAPi

