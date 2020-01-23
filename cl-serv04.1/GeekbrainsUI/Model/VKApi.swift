//
//  VKApi.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 15/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import WebKit
import Alamofire

enum RequestError: Error {
    case failedRequest(message: String)
    case decodableError
}

class VKAPi {
    let vkURL = "https://api.vk.com/method/"
    
    //https://jsonplaceholder.typicode.com/users
    
    //Получение списка друзей
    func getFriendList(token: String, completed: @escaping ([Friend]) ->())  {
        let vkURL = "https://api.vk.com/method/"
        let requestURL = vkURL + "friends.get"
        let params = ["v": "5.103",
                      "access_token":token,
                      "order":"name",
                      "fields":"online,city,domain,photo_50"]
        var localFriends = [Friend]()
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseData( completionHandler: {(response) in
                            guard let data = response.value else {
                                return
                            }
                            
                            do {
                                let response = try JSONDecoder().decode(UserResponse.self, from: data)
                                //print ("получение списка друзей  через JSONDecoder")
                                webVKUser = response.response.items
                                localFriends = response.getFriends(users: webVKUser)
                                //  print(myVKUser)
                            } catch {
                                print(error)
                                
                            }
                             
                            
                            completed(localFriends)
                          })// complectionHandler
        
        
        //       return myVKUser
    }//func getFriendList
    
    //Получение фотографий человека
    func getPhotosList(token: String, userId: Int, completed: @escaping () ->()) {
        let requestURL = vkURL + "photos.get"
        let params = ["v": "5.103",
                      "access_token":token,
                      "owner_id":String(userId),
                      "album_id":"wall"
        ]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseData(completionHandler: { (response) in
                            
                            guard let data = response.value else {
                                return
                            }
                            do{
                                let response = try JSONDecoder().decode(PhotosResponse.self, from: data)
                                //    print ("Получение фотографий текущего пользователя")
                                
                                myPhotos = response.response.items
                                //print(myPhotos)
                                
                            } catch{
                                print (error)
                            }
                            completed()
                          })
        
    }//func getPhotosList
    
    //Получение групп текущего пользователя
    func getGroupsList(token: String, userId: String, completed: @escaping ([Group]) ->()){
        let requestURL = vkURL + "groups.get"
        let params = ["v": "5.103",
                      "access_token":token,
                      "user_id":userId,
                      "extended":"1"
        ]
        var localGroups = [Group]()
        
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseData { (response) in
                            
                            guard let data = response.value else{
                                return
                            }
                            
                            do{
                                let response = try JSONDecoder().decode(GroupResponse.self, from: data)
                                // print ("Получение групп текущего пользователя")
                                webVKGroup = response.response.items
//                                localGroups = response.getGroups(groups: myVKGroup)
                                localGroups = getGroups(groups: webVKGroup)
                                //print(myGroup)
                            } catch{
                                print (error)
                            }
                            completed(localGroups)
        }
    }//func getGroupsList
    
    //Получение групп по поисковому запросу;
    func searchGroups (token: String, query: String, completion: () -> ()){
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


