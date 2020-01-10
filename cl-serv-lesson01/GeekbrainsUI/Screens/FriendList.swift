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

class FriendsDatabase {
    static func getFriends() -> [Friend]{
        return myFriends
    }
}

class FriendList: UITableViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var friends = FriendsDatabase.getFriends()
    
    var friendsSection = [Section<Friend>]()
    var tmpFriend: Friend? //текущий элемент Друг типа структура, на котором стоим
    var selectedFrame: CGRect?
    var customInteractor: CustomInteractor?
    var tmpImage: UIImage? // текущая картинка, на которой стоим
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
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
        var username:String
        
        indexRow = friendsSection[indexPath.section].items[indexPath.row].avatarPath
        username = friendsSection[indexPath.section].items[indexPath.row].userName
        
        if let imageToLoad = indexRow {
            cell.username.text = username
            
            //Либо находим в Assets файл с именем imageToLoad или подставляем default картинку
            if (UIImage(named: "\(imageToLoad)") != nil) {
                cell.userimage.image = UIImage(named: "\(imageToLoad).jpg")
            }
            else {
                cell.userimage.image = UIImage(named: "NewUser.jpg")
            }
            self.tmpImage = cell.userimage.image!
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
        
        let friendID = friendsSection[indexPath.section].items[indexPath.row].id

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //      let viewController = storyboard.instantiateViewController(identifier: "FriendsPhotoViewController") as! FriendsPhotoViewController
       let viewController = storyboard.instantiateViewController(identifier: "PhotoController") as! PhotoController
        
        //находим нужный нам элемент массива Friend как структуру и передаем в след. экран
        for element in (0...friends.count) {
            tmpFriend = friends[element]
            if tmpFriend!.id == friendID {break} //нашли друга
        }
        //вызываем CollectionView и передаем туда структуру с выбранным другом
    viewController.tmpFriend = tmpFriend
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
        friends.append(Friend(userName:name, avatarPath:"NewUser", isOnline:false, id: friends.count,photoArray: ["NewUser"]))
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



/*
         //вызывает экран MusicPlayerViewController
     //запоминает выбранную (песню = экземпляр структуры) и фрейм
         func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
               self.selectedSong = songs[indexPath.row]
               let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
               selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
               self.performSegue(withIdentifier: "Player", sender: self)
           }

     //вызывает анимацию перехода
 //    We want to create a property that stores the frame of the selected cell.  In the didSelectItem function, we want to modify it a little bit so we grab the cells frame, but specifically the frame of the cell relative to that of the ViewController:
     func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
     guard let frame = self.selectedFrame else { return nil }
     guard let song = self.selectedSong else { return nil }

  //       Now we have the selectedFrame, and we can access the selected image from our array of songs, we’re finally ready to implement the CustomAnimator. Because we’ve inherited from UINavigationControllerDelegate, we can implement the method that is used to override the default animation.
     switch operation {
     case .push:
          self.customInteractor = CustomInteractor(attachTo: toVC)
         return CustomAnimator(duration: TimeInterval(UINavigationControllerHideShowBarDuration), isPresenting: true, originFrame: frame, image: song.artwork)
     default:
         return CustomAnimator(duration: TimeInterval(UINavigationControllerHideShowBarDuration), isPresenting: false, originFrame: frame, image: song.artwork)
     }
     }//func navigationController(_ navigationController: UINavigationController, animationControllerFor operation:
     
     
     func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
         guard let ci = customInteractor else { return nil }
         return ci.transitionInProgress ? customInteractor : nil
     }

 */
