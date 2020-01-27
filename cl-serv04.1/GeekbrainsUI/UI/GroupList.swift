//
//  GroupList.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 03/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//



import UIKit



protocol CellImageTapDelegate {
    func tableCell(didClickedImageOf tableCell: GroupCell)
}


class GroupList: UITableViewController, CellImageTapDelegate/*, ImageViewPresenterSource*/ {
    
   // var source: UIView?
    var vkAPI = VKAPi()
    var groups = [Group]()
    
    @IBOutlet weak var groupSearchBar: UISearchBar!
    
    @IBOutlet weak var animationCircle1: UIImageView!
    @IBOutlet weak var animationCircle2: UIImageView!
    @IBOutlet weak var animationCircle3: UIImageView!
    @IBOutlet weak var animationLabel1: UILabel!
    
    var customRefreshControl = UIRefreshControl()
    var vkApi = VKAPi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRefreshControl()
        groupSearchBar.delegate = self //чтобы поиск отрабатывал
        
        //Получение групп текущего пользователя
        vkAPI.getGroupsList(token: Session.shared.token, userId: Session.shared.userId){
            groupsFromWeb in self.groups = groupsFromWeb
            self.tableView.reloadData()
        }
        
    }
    
    
    // функция вызывает анимацию из ячейки класса GroupCell, на которую нажали
    func tableCell(didClickedImageOf tableCell: GroupCell) {
        //       if let rowIndexPath = tableView.indexPath(for: tableCell) {
        //            print("Row Selected of indexPath: \(rowIndexPath)")
        //  }
        tableCell.setAnimation()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.groups.count
        groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTemplate", for: indexPath) as? GroupCell else{ return UITableViewCell()}
        
        
        let ls_indexrow = groups[indexPath.row]
        
        
        cell.groupname.text = ls_indexrow.groupName
        
        //загружаем изображения с кэшем через библиотеку KingFisher
        let url = URL(string: ls_indexrow.avatarPath)
        cell.groupimage.kf.setImage(with: url)
        cell.delegate = self
        
        
        return cell
    } // override func tableView(_ tableView: UITableView, cellForRowAt
    
    //запускаем снег по нажатию соответствующей кнопки
    @IBAction func snowButtonPressed(_ sender: Any) {
        let duration = 30.0
        let emitterSnow = EmitterSnow()
        
        emitterSnow.letItSnow(duration: duration, view: view)
        
        //делаем кнопку недоступной пока идет снег (= duration)
        self.snowButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.snowButton.isEnabled = true
        }
    }
    @IBAction func AddButtonPressed(_ sender: Any) {
        let l_count: Int = groups.count+1
        array_append(name: "NewGroup\(l_count)", id: l_count)
    }
    
    @IBAction func toGroupDetailButtonPressed(_ sender: Any) {
        let animationDuration = 9.0
        //     animationLoad(duration: animationDuration)
        
        self.perform(#selector(navigateToViewController), with: nil, afterDelay: animationDuration)
    }
    
    
    @objc func navigateToViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MessageViewController") as! MessageViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func array_append ( name: String, id: Int){
        //        groups.append(Group(groupName: name, avatarPath: "no", id: id))
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell:
        UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    //Добавляем ф-л удаления строчки через UITableViewCell.EditingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete{
            groups.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    func array_delete ( row: Int){
        groups.remove(at: row)
        tableView.reloadData()
    }
    
    
    func addRefreshControl(){
        customRefreshControl.attributedTitle = NSAttributedString(string:"refreshing...")
        customRefreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.addSubview(customRefreshControl)
    }
    
    @objc func refreshTable(){
        //фейковая функция, имитирует обновление из интернета
        
        //функция DispatchQueue дает паузу в 3 сек...
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            //... и закрывает refreshing
            self.customRefreshControl.endRefreshing()
        }
    }
    

    
    
    @IBOutlet weak var snowButton: UIBarButtonItem!
    

}//class GroupList

extension GroupList: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        groups =  getGroups(groups: webVKGroup).filter{ (group) -> Bool in
            return searchText.isEmpty ? true : (group.groupName.lowercased()).contains(searchText.lowercased())
        }
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}




