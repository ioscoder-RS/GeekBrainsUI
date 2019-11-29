//
//  ViewController.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 23/11/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate //для фокусирования курсора на текстовое поле
{
    //сохранил связь, т.к. не смог корректно удалить
    //@IBOutlet var Login: [UILabel]!
    
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
    
    @IBAction func Reg_pressed(_ sender: Any) {
        // Создаем контроллер
        let alert = UIAlertController(title: "Ошибка", message: "Регистрация будет доступна в след. версиях", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.Login2.becomeFirstResponder()}) //в handler добавили текстовое поле, чтобы на него сфокусироваться
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        // Показываем UIAlertController
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func ButtonPressed(_ sender: Any) {
        guard let loginInput = Login2.text else {return}
        guard let passwordInput = Password.text else {return}
        
   //добавляем обработку ошибок
      if (loginInput == "")||(passwordInput == "") {
        
        // Создаем контроллер
        let alert = UIAlertController(title: "Ошибка", message: "Авторизуйтесь для работы с приложением", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.Login2.becomeFirstResponder()}) //в handler добавили текстовое поле, чтобы на него сфокусироваться
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        // Показываем UIAlertController
        present(alert, animated: true, completion: nil)
        
        }

    }
}

