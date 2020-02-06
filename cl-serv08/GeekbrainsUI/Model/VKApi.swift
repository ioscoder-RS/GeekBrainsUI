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

enum WebRequestEntities{
    case VKUser
    case VKGroup
    case VKPhoto
}


class VKAPi {
    let vkURL = "https://api.vk.com/method/"
    //https://jsonplaceholder.typicode.com/users
    
//    typealias Out = Swift.Result
    
    func sendRequest<T: Decodable>(url:String, method: HTTPMethod = .get, params: Parameters,  webRequestEntity: WebRequestEntities, completion: @escaping (Out<[T],Error>)-> Void){
        
        Alamofire.request(url,method: method,parameters: params).responseData { (result) in
                                guard let data = result.value else {return}
            
            do{
                let result = try JSONDecoder().decode(CommonResponse<T>.self, from: data)
                //сохраняем в глобальные переменные то, что пришло из Web
                switch webRequestEntity{
                case .VKUser:
                    webVKUsers = result.response.items as! [VKUser]
                case .VKGroup:
                    webVKGroups = result.response.items as! [VKGroup]
                case .VKPhoto:
                    webVKPhotos = result.response.items as! [VKPhoto]
                }//switch
                
                completion(.success(result.response.items))
            }catch{
                completion(.failure(error))
            }
    }
    }//func sendRequest
    
    //Получение списка друзей
    func getFriendList(token: String,completion: @escaping (Out<[VKUser],Error>)-> Void) {
    
        let requestURL = vkURL + "friends.get"
        let params = ["v": "5.103",
                      "access_token":token,
                      "order":"name",
                      "fields":"online,city,domain,photo_50"]

        sendRequest(url: requestURL, params: params, webRequestEntity: WebRequestEntities.VKUser ) {completion($0)}
                            
    }//func getFriendList
    
    //Получение фотографий человека
    func getPhotosList(token: String, userId: Int, completion: @escaping (Out<[VKPhoto], Error>)-> Void) {
        let requestURL = vkURL + "photos.get"
        let params = ["v": "5.103",
                      "access_token":token,
                      "owner_id":String(userId),
                      "extended":"1",
                      "album_id":"wall"
        ]
        
       sendRequest(url: requestURL, params: params, webRequestEntity: WebRequestEntities.VKPhoto) {completion($0)}
    }//func getPhotosList
    
    //Получение групп текущего пользователя
    func getGroupsList(token: String, userId: String, completion: @escaping (Out<[VKGroup], Error>)-> Void) {
        let requestURL = vkURL + "groups.get"
        let params = ["v": "5.103",
                      "access_token":token,
                      "user_id":userId,
                      "extended":"1"
        ]
        
        sendRequest(url: requestURL, params: params, webRequestEntity: WebRequestEntities.VKGroup) {completion($0)}
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


