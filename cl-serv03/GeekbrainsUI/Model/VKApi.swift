//
//  VKApi.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 15/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import WebKit
import Alamofire


struct GroupVK: Decodable {
    var id: Int = 0
    var name: String = ""
    var isAdmin: Int = 0
    var lat: Double = 0.0
    

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isAdmin = "is_admin"
        case address
    }
    
    enum AddressKeys: String, CodingKey {
        case geo
    }
    
    enum GeoKeys: String, CodingKey{
        case lat
    }
    
    init (from decoder: Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
        let addressContainer = try mainContainer.nestedContainer(keyedBy: AddressKeys.self, forKey: .address)
        let geoContainer = try addressContainer.nestedContainer(keyedBy: GeoKeys.self, forKey: .geo)
        self.lat = try geoContainer.decode(Double.self, forKey: .lat)
        self.id = try mainContainer.decode(Int.self, forKey: .id)
    }
}




class VKAPi {
    let vkURL = "https://api.vk.com/method/"
    
    //https://jsonplaceholder.typicode.com/users

        
    
    //Получение списка друзей
    func getFriendList(token: String, completion: () -> ())  {
        let requestURL = vkURL + "friends.get"
        let params = ["v": "5.103",
                      "access_token":token,
                      "order":"name",
                      "fields":"online,city,domain,photo_50"]
        
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseData { (response) in
                            guard let data = response.value else {
                                return
                            }
//                            print ("получение списка друзей")
//                            print(String(bytes: data, encoding: .utf8)!)
                            
                            do {
                                let response = try JSONDecoder().decode(UserResponse.self, from: data)
                                  print ("получение списка друзей  через JSONDecoder")
                              myVKUser = response.response.items
                                
                                print(myVKUser)
                            } catch {
                                print(error)
                            }
                            
        }
        
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
                          parameters: params).responseData(completionHandler: { (response) in
                            
                                guard let data = response.value else {
                                return
                            }
                            do{
                                let response = try JSONDecoder().decode(PhotosResponse.self, from: data)
                                print ("Получение фотографий текущего пользователя")
                                
                                var myPhotos: [VKPhoto] = response.response.items
                                print(myPhotos)
                            } catch{
                                print (error)
                            }
                            
                          })
        
        
    }//func getPhotosList
    
    //Получение групп текущего пользователя
    func getGroupsList(token: String, userId: String, completion: () -> ()){
        let requestURL = vkURL + "groups.get"
        let params = ["v": "5.103",
                      "access_token":token,
                      "user_id":userId,
                      "extended":"1"
        ]
        
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseData { (response) in
                            
                            guard let data = response.value else{
                                return
                            }
                            
                            do{
                                let response = try JSONDecoder().decode(GroupResponse.self, from: data)
                                print ("Получение групп текущего пользователя")
                                myGroup = response.response.items
                                print(myGroup)
                            } catch{
                                print (error)
                            }

                            
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

