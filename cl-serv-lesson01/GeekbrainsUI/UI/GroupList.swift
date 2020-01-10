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
            Group(groupName:"Одноклассники", avatarPath:"Group2", id:1),
            Group(groupName:"Семья", avatarPath:"Group1", id:2),
            Group(groupName:"Рязань-2000", avatarPath:"2", id:3),
            Group(groupName:"Любители коров", avatarPath:"3", id:4)
        ]
    }
}

protocol CellImageTapDelegate {
    func tableCell(didClickedImageOf tableCell: GroupCell)
}


class GroupList: UITableViewController, CellImageTapDelegate, ImageViewPresenterSource {
    
    var source: UIView?
    
    @IBOutlet weak var groupSearchBar: UISearchBar!
    
    @IBOutlet weak var animationCircle1: UIImageView!
    @IBOutlet weak var animationCircle2: UIImageView!
    @IBOutlet weak var animationCircle3: UIImageView!
    @IBOutlet weak var animationLabel1: UILabel!
    
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
     /*
        cell.viewClicked = {[weak self] view .in
            guard let self = self else {
                return
            }
            self.source = view
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "LoginViewController")
            self.navigationController?.delegate = imageViewerPresenter(delegate: self)
            self.navigationController?.pushViewController(vc, animated: true)
        }
       */
        
        return cell
    } // override func tableView(_ tableView: UITableView, cellForRowAt
    
    
    @IBAction func snowButtonPressed(_ sender: Any) {
        let duration = 30.0
        letItSnow(duration: duration)
        
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
        animationLoad(duration: animationDuration)
        
        self.perform(#selector(navigateToViewController), with: nil, afterDelay: animationDuration)
    }
    
    
    @objc func navigateToViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MessageViewController") as! MessageViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func array_append ( name: String, id: Int){
        groups.append(Group(groupName: name, avatarPath: "no", id: id))
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
    
    //функция выводит три мигающих круга
    func animationLoad(duration: Double){
        
        //animationLabel1.isHidden = false
        animationCircle1.isHidden = false
        
        UIView.animate( withDuration: duration/5,
                        delay: 0.0,
                        options: [.repeat,.autoreverse],
                        animations:{ self.animationCircle1.alpha = 0.3},
                        completion: { _ in  UIView.animate( withDuration: duration/5,
                                                            delay: 0.0,
                                                            options: [],
                                                            animations:{ self.animationCircle1.alpha = 1; self.animationCircle1.isHidden = true}) })
        
        animationCircle2.isHidden = false
        UIView.animate( withDuration: duration/5,
                        delay: 1.0,
                        options: [.repeat,.autoreverse],
                        animations:{ self.animationCircle2.alpha = 0.3},
                        completion: { _ in  UIView.animate( withDuration: duration/5,
                                                            delay: 0.0,
                                                            options: [],
                                                            animations:{ self.animationCircle2.alpha = 1; self.animationCircle2.isHidden = true}) })
        
        animationCircle3.isHidden = false
        UIView.animate( withDuration: duration/5,
                        delay: 2.0,
                        options: [.repeat,.autoreverse],
                        animations:{ self.animationCircle3.alpha = 0.3},
                        completion: { _ in  UIView.animate( withDuration: duration/5,
                                                            delay: 0.0,
                                                            options: [],
                                                            animations:{ self.animationCircle3.alpha = 1; self.animationCircle3.isHidden = true}) })
        
        animationLabel1.isHidden = true
        
        /*
         //делаем кнопку недоступной пока идет снег (= duration)
         self.toGroup.isEnabled = false
         DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
         self.snowButton.isEnabled = true
         }
         */
    }
    
    
    @IBOutlet weak var snowButton: UIBarButtonItem!
    
    //функция посыпает снегом
    func letItSnow(duration: Double){
        let emitterSnow = CAEmitterCell()
        emitterSnow.contents = UIImage(named:"snow")?.cgImage
        emitterSnow.scale = 0.01
        emitterSnow.scaleRange = 0.03
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



