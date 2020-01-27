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
    
    var vkAPI = VKAPi()
    var friends = [Friend]()
    var friendsSection = [Section<Friend>]()
    //   var tmpFriend: VKUser? //текущий элемент Друг типа структура, на котором стоим
    var tmpFriend: Friend?
    //массив фотографий для передачи в PhotoController
    var photoArray = [VKPhoto]()
    //получение списк пользователей
    var tmpVKUser = [VKUser]()
    var selectedFrame: CGRect?
    var customInteractor: CustomInteractor?
    var tmpImage: UIImage? // текущая картинка, на которой стоим
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        getFriendList()
    }// override func viewDidLoad()
    
    private func getFriendList(){
        //Получаем пользователей из Web
   
        //    var users:[VKUser]
        
        vkAPI.getFriendList(token: Session.shared.token){  result in
            switch result {
            case .success(let users):
                self.friends = getFriends(users: users)
                     //в closure перерисовываем tableView -  чтобы только по завершению вывести на экран
                self.initFriendSection()
                self.tableView.reloadData()
            case .failure(let error):
                print("we got error: \(error)")
            }//switch case
        }//completion
    }//func getGriendList
    

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
        
        let friendsDictionary = Dictionary.init (grouping: friends.filter{ (user) -> Bool in return searchText.isEmpty ? true : user.userName.lowercased().contains(searchText.lowercased())}){
            $0.userName.prefix(1)
        }
        friendsSection = friendsDictionary.map {Section(title:String($0.key),items: $0.value) }
        friendsSection.sort {$0.title < $1.title}
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

