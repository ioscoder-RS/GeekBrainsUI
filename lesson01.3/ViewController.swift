//
//  ViewController.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 23/11/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

 

    
    //сохранил связь, т.к. не смог корректно удалить
    @IBOutlet var Login: [UILabel]!
    
   // текст вводимого логина в этом контроллере - Login2
    @IBOutlet weak var Login2: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let HideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(HideAction)
    }
//функция, убирающая клавиатуру с экрана при нажатии вне текстового поля
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func ButtonPressed(_ sender: Any) {
        guard let loginInput = Login2.text else {return}
        guard let passwordInput = Password.text else {return}
        
   //добавляем обработку ошибок
        if loginInput == "" {
            print("не введен логин")
            return
        }
        if passwordInput == "" {
            print("не введен пароль")
            return
        }
   print(loginInput + " " + passwordInput)
    }
}

