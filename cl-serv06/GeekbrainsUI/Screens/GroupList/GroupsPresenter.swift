//
//  GroupsPresenter.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 29/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import Foundation

class GroupPresenterImplementation {
    var vkApi = VKAPi()
    var databaseMode = true
    var groupRepository = GroupRepository()
    typealias Out = Swift.Result
    
     func getGroupList(completion: @escaping (Out<[Group],Error>)-> Void) {
         //Получаем группы из Web
        var localGroups = [Group]()
        
        vkApi.getGroupsList (token: Session.shared.token, userId: Session.shared.userId){  result in
             switch result {
             case .success(var webGroups):
                if self.databaseMode == true {
                 //запоминаем в БД
                // self.presenter.saveFriendListtoDB(usersToSave: webUsers)
                 self.putToDB(groupsToSave: webGroups, databaseType: .Realm)    {
                                              result in
                                              switch result{
                                              case .success:
                                                  
                                                  do {
                                                       webGroups = Array(try self.groupRepository.getAllGroups()).map{ $0.toModel()}
                                                     //webUsers = Array(try self.userRepository.getAllfromTable(vkObject: .VKUser))

                                                  } catch {
                                                      print(error)
                                                  }
                                              
                                              case .failure (let error):
                                                  print("we got error on getGroupList: \(error)")
                                              }//switch
                                          }
                }//if self.databaseMode = true
                localGroups = convertGroups(groups: webGroups)
               
                      //в closure перерисовываем tableView -  чтобы только по завершению вывести на экран
       //          self.tableView.reloadData()
                completion(.success(localGroups))
             case .failure(let error):
                completion(.failure(error))
             }//switch case
         }//completion
   
     }//func getGroupList
    
    func putToDB (groupsToSave: [VKGroup], databaseType: DatabaseType, completion: @escaping (Swift.Result<[VKUser], Error>) -> ())
      {
          switch databaseType {
          case .CoreData:
            let a = 2
          case .Realm:
            let groupRepository = GroupRepository()
              groupRepository.addGroups(groups: groupsToSave)
          }
      }
}//class GroupPresenterImplementation
