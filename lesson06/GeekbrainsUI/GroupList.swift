//
//  GroupList.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 03/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//


//На второй вкладке UITableViewController должен отображать группы пользователя. Прототип должен содержать текстовую надпись для имени группы и изображение для ее аватарки.
//Второй UITableViewController будет отображать группы, в которых пользователь не состоит. В будущем мы добавим возможность поиска сообщества по названию. Ячейки должны использоваться такие же, как и на прошлом контроллере.

import UIKit

class GroupList: UITableViewController {
 
    var customRefreshControl = UIRefreshControl()
    
    var lv_grouplist = ["Group1", "Group2", "Group3", "Group4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
 addRefreshControl()
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
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return lv_grouplist.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTemplate", for: indexPath) as! GroupCell
        
        var ls_indexrow:String?
        
        ls_indexrow = lv_grouplist[indexPath.row]
         
         if let imageToLoad = ls_indexrow {
        
         cell.groupname.text = imageToLoad
            //хулиганство - присваиваю пользователям NewUser5, NewUser6,...NewUserX иконку с названием NewUser.
                      var ls_defaultgroupname:String
                      if imageToLoad.hasPrefix("NewGroup") == true{
                          ls_defaultgroupname = "NewGroup"
                      } else{
                          ls_defaultgroupname = imageToLoad
                      }
                  cell.groupimage.image = UIImage(named: "\(ls_defaultgroupname).jpg")
                  }
        return cell
    }
    @IBAction func AddButtonPressed(_ sender: Any) {
        let l_count: Int = lv_grouplist.count+1
        array_append(name: "NewGroup\(l_count)")
    }
    
    func array_append ( name: String){
          lv_grouplist.append(name)
          tableView.reloadData()
      }
   
    //Добавляем ф-л удаления строчки через UITableViewCell.EditingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
     {
        if editingStyle == .delete{
        lv_grouplist.remove(at: indexPath.row)
        tableView.reloadData()
        }
    }
    func array_delete ( row: Int){
        lv_grouplist.remove(at: row)
        tableView.reloadData()
    }
}//class GroupList
