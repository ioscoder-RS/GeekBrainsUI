//
//  FriendList.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 01/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

struct Section<T>{
    var title: String
    var items: [T]
}

class FriendList: UITableViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: переменные отображения списка пользователей
    var tmpVKUser = [VKUser]()//Массив пользователей в формате Web-запроса
    var friends = [Friend]() //Массив пользователей. Формат для отображения
    var initialFriends = [Friend]() //Первоначально загруженный массив пользователей . Формат для отображения
    var tmpFriend: Friend?  //текущий пользователь из строки таблицы
    var friendsSection = [Section<Friend>]() //массив секций
    //массив фотографий для передачи в PhotoController
    var photoArray = [VKPhoto]()
 
    //Класс Web-запроса
    private var vkAPI = VKAPi()
    
    //MARK: переменные взаимодействия с БД
   //CoreData
    private var presenterCD = FriendListPresenterImplementation(database: FriendCoreDataRepository(stack: CoreDataStack.shared), api: VKAPi())
    //Realm
     private var userRepository = UserRepository()
    var database = VKUserRealm()
    
    //Признак взаимодействуем ли вообще с Базой Данных
    let databaseMode = true
    
    var presenter = FriendsPresenterImplementation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
 //       getFriendList()//получение списка клиентов и по параметру сохранение в БД
        
        //MARK: вдруг так правильнее
//        presenter = FriendsPresenterImplementation()
//        presenter?.viewDidLoad()
//        presenter?.getFriendList()
        
        presenter.getFriendList(){
            result in
            switch result{
            case .success (let friends):
                  self.friends = friends
                  self.initialFriends = friends
                  self.showfriends()
            case .failure (let error):
                print(error)
            }//switch
        }//completion getGroupList
     
    }// override func viewDidLoad()
    
    func showfriends(){
        //в результате имеем массив пользователей, либо напрямую из Web, либо из БД (для databaseMode = true)
        
        //в closure перерисовываем tableView -  чтобы только по завершению вывести на экран
        self.initFriendSection()
        self.tableView.reloadData()
    }
    

    private func initFriendSection(){
        
        let friendsDictionary = Dictionary.init (grouping: friends){
            $0.userName.prefix(1)
        }
        friendsSection = friendsDictionary.map {Section(title:String($0.key),items: $0.value) }
        //       print(friendsDictionary)
        friendsSection.sort {$0.title < $1.title}
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return friendsSection.count
        //        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsSection[section].items.count
    }
    
    //заполняем строки именем пользователя и, если получится, картинкой
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTemplate", for: indexPath) as? FriendCell else{
            return UITableViewCell()
        }
        
        var indexRow:String?
        var username:String
        
        indexRow = friendsSection[indexPath.section].items[indexPath.row].avatarPath
        username = friendsSection[indexPath.section].items[indexPath.row].userName
        
        cell.username.text = username
        let url = URL(string: indexRow ?? "")
        //загружаем изображения с кэшем через библиотеку KingFisher
        cell.userimage.kf.setImage(with: url)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsSection[section].title
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsSection.map{$0.title}
    }
    
    //вызываем CollectionView по клику
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let friendID = friendsSection[indexPath.section].items[indexPath.row].id
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "PhotoController") as! PhotoController
        
        //находим нужный нам элемент массива Friend как структуру и передаем в след. экран
        for element in (0...friends.count) {
            tmpFriend = friends[element]
            if tmpFriend!.id == friendID {break} //нашли друга
        }
        
        //заполняем массив фото
        //Получаем фотки из Web
        
        vkAPI.getPhotosList(token: Session.shared.token, userId: friendID){  result in
            switch result {
            case .success(let photos):
                self.photoArray = photos
                //вызываем CollectionView и передаем туда структуру с выбранным другом
                viewController.tmpFriend = self.tmpFriend
                viewController.photoArray = self.photoArray
                self.navigationController?.pushViewController(viewController, animated: true)
                
            case .failure(let error):
                print("we got error: \(error)")
            }//switch case
        }//completion
        
    }//override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    
    //Добавляем по кнопке новый элемент в массив
    @IBAction func AddButtonPressed(_ sender: Any) {
        let count: Int = friends.count+1
        arrayAppend(name: "NewUser\(count)")
    }
    
    //Добавляем ф-л удаления строчки через UITableViewCell.EditingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete{
            let username = friendsSection[indexPath.section].items[indexPath.row].userName
            
            friends = friends.filter({(Friend) in
                return Bool(Friend.userName != username)
            })
            //перерисовываем отображение в секциях
            initFriendSection()
            tableView.reloadData()
        }
    }
    
    func arrayAppend ( name: String){
        //добавляем запись в исходный массив
        //        friends.append(Friend(userName:name, avatarPath:"NewUser", isOnline:false, id: friends.count,photoArray: ["NewUser"]))
        //перерисовываем отображение в секциях
        initFriendSection()
        tableView.reloadData()
    }
    
    func arrayDelete ( row: Int){
        friends.remove(at: row)
        tableView.reloadData()
    }
    
}// class FriendList

extension FriendList: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if databaseMode == true {
        //MARK: пока только для Realm,
            //ищем в БД
        do {
            //MARK: вернуть как удастся побороть рантайм на getAllUsers
//            self.tmpVKUser = searchText.isEmpty ?
//            //Array(try self.userRepository.getAllUsers()).map{ $0.toModel()} :
//            Array(try self.userRepository.searchUsers(name: searchText)).map { $0.toModel()}
            
            if searchText.isEmpty != true {
                self.tmpVKUser = Array(try self.userRepository.searchUsers(name: searchText)).map { $0.toModel()}
                self.friends = convertFriends(users: tmpVKUser)
            }
            else{
                self.friends = self.initialFriends
            }
         
            
            let friendsDictionary = Dictionary(grouping: self.friends) {$0.userName.prefix(1)}
            
            friendsSection = friendsDictionary.map {Section(title:String($0.key),items: $0.value) }
            friendsSection.sort {$0.title < $1.title}
            tableView.reloadData()
        } catch {
            print(error)
        }
        }//if databaseMode == true
            else { //фильтруем не БД а tableView
                        let friendsDictionary = Dictionary.init (grouping: friends.filter{ (user) -> Bool in return searchText.isEmpty ?
                            true:
                            user.userName.lowercased().contains(searchText.lowercased())}){$0.userName.prefix(1)}
            }
    }//func searchBar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
  
}//class FriendList

