//
//  FriendList.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 01/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//



import UIKit


struct Section<T>{
    var title: String
    var items: [T]
}

class FriendList: UITableViewController {

    var friends = [Friend(userName:"UserOne", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"AserTwo", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"UserTwo", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"AserFour", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"BserThree", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"DserFour", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"UserThree", avatarPath:"NewUser", isOnline:false),
                   Friend(userName:"CserFour", avatarPath:"NewUser", isOnline:false)
]
    
    var friendsSection = [Section<Friend>]()
    
    override func viewDidLoad() {
       // super.viewDidLoad()
      initFriendSection()
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
       
        indexRow = friendsSection[indexPath.section].items[indexPath.row].userName
        
        if let imageToLoad = indexRow {
        cell.username.text = imageToLoad
            
         //Либо находим в Assets файл с именем imageToLoad или подставляем default картинку
            if (UIImage(named: "\(imageToLoad)") != nil) {
              cell.userimage.image = UIImage(named: "\(imageToLoad).jpg")
            }
            else {
              cell.userimage.image = UIImage(named: "NewUser.jpg")
            }
      

        }
        

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
        let username = friendsSection[indexPath.section].items[indexPath.row].userName
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "PhotoController") as! PhotoController
        viewController.inputUser = username
    self.navigationController?.pushViewController(viewController, animated: true)
    }

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
        friends.append(Friend(userName:name, avatarPath:"NewUser", isOnline:false))
//перерисовываем отображение в секциях
        initFriendSection()
        tableView.reloadData()
    }
    
    func arrayDelete ( row: Int){
        friends.remove(at: row)
        tableView.reloadData()
    }


}

