//
//  FirstScreen.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 04/02/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import UIKit

class FirstScreen: UIViewController {
    @IBOutlet weak var currentUser: UIButton!
    @IBOutlet weak var changeUser: UIButton!
    @IBOutlet weak var workOfflie: UIButton!
    @IBOutlet weak var cleanDatabase: UIButton!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        initUI()
    }
    
    func initUI(){
        currentUser.setTitle("Логин текущим пользователем", for: .normal)
        changeUser.isHidden = true
        changeUser.setTitle("Cменить пользователя \(Session.shared.userId)", for: .normal)
        workOfflie.setTitle("Работать через Firebase (БД офлайн)", for: .normal)
        cleanDatabase.setTitle("Очистить локальную БД", for: .normal)
    }
    
    @IBAction func currentUserPressed(_ sender: Any) {
        webMode = true //работаем с интернетом
        transitionToTabBar(screenName: "VKLoginController")
    }
    
    @IBAction func changeUserPressed(_ sender: Any) {
    }
    
    @IBAction func workOfflinePressed(_ sender: Any) {
        webMode = false //работаем без интернета
        transitionToTabBar(screenName: "LocalLoginController")
    }
    
    @IBAction func cleanDatabasePressed(_ sender: Any) {
        let cr = CommonRepository()
        
        showYesNoMessage(view: self, title: "Внимание!", messagetext: "Вы действительно хотите удалить все данные из локальной БД!") { (result) in
            if result { //User has clicked on Ok
//                cr.deleteVKObject(object: .VKUser)
//                cr.deleteVKObject(object: .VKGroup)
//                cr.deleteVKObject(object: .VKPhoto)
                
                cr.deleteAllRealmTables ()
            } else { //User has clicked on Cancel
                return
            }
        }
        
        
    }
    
    private func transitionToTabBar(screenName: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: screenName)
        vc.modalPresentationStyle = .custom
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}//class FirstScreen: UIViewController
