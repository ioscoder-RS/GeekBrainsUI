//
//  FriendsPresenter.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 29/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import Foundation

protocol FriendsPresenter{
    typealias Out = Swift.Result
    
   func viewDidLoad()
    func getUsers()
    func getFriendList(completion: @escaping (Out<[Friend],Error>)-> Void)
}

 

class FriendsPresenterImplementation : FriendsPresenter {

    var friends = [Friend]()
    
    private var vkAPI: VKAPi
    private var userRepository: UserRepository
     
    
        var presenterCD = FriendListPresenterImplementation(database: FriendCoreDataRepository(stack: CoreDataStack.shared), api: VKAPi())
    
    let databaseMode = true
    //Realm
    var database = VKUserRealm()
    
    typealias Out = Swift.Result
    
    func viewDidLoad() {
 
    }
    
    func getFriendList(completion: @escaping (Out<[Friend],Error>)-> Void){
                    // MARK: - Функция получает из Web список пользователей
                    // MARK: если databaseMode = true - дополнительно сохраняет в БД, иначе - просто выводит
                    
      var localFriends = [Friend]()
        
                    //Получаем пользователей из Web
                    vkAPI.getFriendList(token: Session.shared.token){  result in
                        switch result {
                        case .success(var webUsers): //массив VKUser из Web
                            if self.databaseMode == true {
                                //запоминаем в БД
                               // self.presenter.saveFriendListtoDB(usersToSave: webUsers)
                                self.putToDB(usersToSave: webUsers, databaseType: .Realm)
                                  {
                                    result in
                                    switch result{
                                    case .success:
                                        //извлекаем из БД сохраненный там массив пользователей
                                        //можно кстати не извлекать и использовать сразу savedUsers - но так честнее
                                        
                              //          Для CoreData
            //                            webUsers = self.presenter.getFriendsFromDatabase()
                                        
                                        do {
                                             webUsers = Array(try self.userRepository.getAllUsers()).map{ $0.toModel()}
                                           //webUsers = Array(try self.userRepository.getAllfromTable(vkObject: .VKUser))

                                        } catch {
                                            print(error)
                                        }
                                    
                                    case .failure (let error):
                                        print("we got error on presenter.saveFriendListtoDB: \(error)")
                                    }//switch
                                }// self.presenter.saveFriendListtoDB
                            } //if self.databaseMode == true
                            else{
                                //ничего пока не делаем для варианта без сохранения в DB
                            }
                            //преобразовываем результат в формат структуры отображения = [Friend]
                            localFriends = convertFriends(users: webUsers)
                             completion(.success(localFriends))
                           
                        case .failure(let error):
                            completion(.failure(error))
                        }//switch case
                    }//completion
                }//func getGriendList
            
            func putToDB (usersToSave: [VKUser], databaseType: DatabaseType, completion: @escaping (Swift.Result<[VKUser], Error>) -> ())
              {
                  switch databaseType {
                  case .CoreData:
                      self.presenterCD.saveFriendListtoDB(usersToSave: usersToSave){
                          result in switch result {
                          case .success(_):
                              completion(result)
                          case .failure(let error):
                              print("we got error in putToDB: \(error)")
                          }
                      }
                  case .Realm:
                      userRepository.addUsers(users: usersToSave)
                  }
              }
    func getUsers() {
        
    }
    
    init () {
        vkAPI = VKAPi()
        userRepository = UserRepository()
    }
    
}//class

