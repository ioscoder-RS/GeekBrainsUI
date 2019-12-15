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

class GroupDatabase {
    static func getGroups() -> [Group]{
        return [
            Group(groupName:"Group2", avatarPath:"Group2", id:1),
            Group(groupName:"Group1", avatarPath:"Group1", id:2),
             Group(groupName:"Group4", avatarPath:"2", id:3),
              Group(groupName:"3", avatarPath:"3", id:4)
        ]
    }
}

protocol CellImageTapDelegate {
    func tableCell(didClickedImageOf tableCell: GroupCell)
}

class GroupList: UITableViewController, CellImageTapDelegate {
 

    @IBOutlet weak var groupSearchBar: UISearchBar!
    
    var customRefreshControl = UIRefreshControl()
    var groups = GroupDatabase.getGroups()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        groupSearchBar.delegate = self //чтобы поиск отрабатывал
        
    }

    
    // функция вызывает анимацию из ячейки класса GroupCell, на которую нажали
    func tableCell(didClickedImageOf tableCell: GroupCell) {
 //       if let rowIndexPath = tableView.indexPath(for: tableCell) {
//            print("Row Selected of indexPath: \(rowIndexPath)")
  //  }
            tableCell.setAnimation()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTemplate", for: indexPath) as? GroupCell else{ return UITableViewCell()}
        
        var ls_indexrow:String?
        
        ls_indexrow = groups[indexPath.row].groupName
         
         if let imageToLoad = ls_indexrow {
        
         cell.groupname.text = imageToLoad
           
        //Либо находим в Assets файл с именем imageToLoad или подставляем default картинку
           if (UIImage(named: "\(imageToLoad)") != nil) {
             cell.groupimage.image = UIImage(named: "\(imageToLoad).jpg")
           }
           else {
             cell.groupimage.image = UIImage(named: "NewGroup.jpg")
           }
        }
        
      cell.delegate = self

        return cell
    } // override func tableView(_ tableView: UITableView, cellForRowAt
    

    @IBAction func snowButtonPressed(_ sender: Any) {
        letItSnow(duration: 30)
    }
    @IBAction func AddButtonPressed(_ sender: Any) {
        let l_count: Int = groups.count+1
        array_append(name: "NewGroup\(l_count)", id: l_count)
    }
    
    func array_append ( name: String, id: Int){
          groups.append(Group(groupName: name, avatarPath: "no", id: id))
          tableView.reloadData()
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
    
    //функция посыпает снегом
    func letItSnow(duration: Double){
        let emitterSnow = CAEmitterCell()
          emitterSnow.contents = UIImage(named:"snow")?.cgImage
          emitterSnow.scale = 0.02
          emitterSnow.scaleRange = 0.05
          emitterSnow.birthRate = 40
          emitterSnow.lifetime = 10
          emitterSnow.velocity = -30
          emitterSnow.velocityRange = -20
          emitterSnow.yAcceleration = 30
          emitterSnow.xAcceleration = 5
          emitterSnow.spin = -0.5
          emitterSnow.spinRange = 1.0

          let snowEmitterLayer = CAEmitterLayer()
        
        // центр анимации
          snowEmitterLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: 50)
          snowEmitterLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
          snowEmitterLayer.emitterShape = .circle
          snowEmitterLayer.beginTime = CACurrentMediaTime() + 0.5
  //        snowEmitterLayer.timeOffset = 10
          snowEmitterLayer.duration = duration
          snowEmitterLayer.emitterCells = [emitterSnow]
        
         view.layer.addSublayer(snowEmitterLayer)
  
        //делаем кнопку недоступной пока идет снег (= duration)
        self.snowButton.isEnabled = false
          DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
          self.snowButton.isEnabled = true
          }
        
    }
}//class GroupList

extension GroupList: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        groups =  GroupDatabase.getGroups().filter{ (group) -> Bool in
            return searchText.isEmpty ? true : group.groupName.lowercased().contains(searchText.lowercased())
            }
    tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}


