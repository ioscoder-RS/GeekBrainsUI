//
//  FriendList.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 01/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//


//На основе ПЗ предыдущего урока:
//Добавить на все контроллеры прототипы ячеек.
//На первой вкладке UITableViewController должен отображать список друзей пользователя. В прототипе ячеек должна быть текстовая надпись с именем друга и изображением с его аватаркой.
//UICollectionViewController должен отображать фото выбранного друга. Соответственно, в прототипе ячейки должно быть изображение.
//На второй вкладке UITableViewController должен отображать группы пользователя. Прототип должен содержать текстовую надпись для имени группы и изображение для ее аватарки.
//Второй UITableViewController будет отображать группы, в которых пользователь не состоит. В будущем мы добавим возможность поиска сообщества по названию. Ячейки должны использоваться такие же, как и на прошлом контроллере.
//Создать папку Model, а в ней — файлы содержащие struct, или class, описывающий профиль пользователя, — User, группу «ВКонтакте» — Group.
//Подготовить массивы демонстрационных данных, отобразить эти данные на соответствующих им экранах.
//Реализовать добавление и удаление групп пользователя.




import UIKit

class FriendList: UITableViewController {

    var friendList = ["UserOne", "UserTwo", "UserThree", "UserFour"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
//заполняем строки именем пользователя и, если получится, картинкой
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTemplate", for: indexPath) as! FriendCell
        
        var ls_indexrow:String?
       
       ls_indexrow = friendList[indexPath.row]
        
        if let imageToLoad = ls_indexrow {
        cell.username.text = imageToLoad
//        print("ls_indexrow = \(imageToLoad)")
            
   //хулиганство - присваиваю пользователям NewUser5, NewUser6,...NewUserX иконку с названием NewUser.
            var ls_defaultusername:String
            if imageToLoad.hasPrefix("NewUser") == true{
                ls_defaultusername = "NewUser"
            } else{
                ls_defaultusername = imageToLoad
            }
        cell.userimage.image = UIImage(named: "\(ls_defaultusername).jpg")
        }
        return cell
    }
    //вызываем CollectionView по клику
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let username = friendList[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "PhotoController") as! PhotoController
        viewController.user = username
    self.navigationController?.pushViewController(viewController, animated: true)
    }

    //Добавляем по кнопке новый элемент в массив, в конец
    @IBAction func AddButtonPressed(_ sender: Any) {
        let l_count: Int = friendList.count+1
        array_append(name: "NewUser\(l_count)")
    }
    
    //Добавляем ф-л удаления строчки через UITableViewCell.EditingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
     {
        if editingStyle == .delete{
        friendList.remove(at: indexPath.row)
        tableView.reloadData()
        }
    }
    
    
    func array_append ( name: String){
        friendList.append(name)
        tableView.reloadData()
    }
    
    func array_delete ( row: Int){
        friendList.remove(at: row)
        tableView.reloadData()
    }
    
}

