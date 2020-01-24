//
//  ViewController.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 23/11/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

private let debugMode = 0 //1 - debug on, 0 - debug off

class LoginViewController: UIViewController, UITextFieldDelegate //для фокусирования курсора на текстовое поле
{
    
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var Login2: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var logo: UIImageView!
    
    //для функции анимации на лого
    var propertyAnimator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 1.0, dampingRatio: 1.0, animations:{})
    
    var vkAPI = VKAPi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let HideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(HideAction)
        
        
        
    }
    
    
    //функция, убирающая клавиатуру с экрана при нажатии вне текстового поля
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    
    @IBAction func RegPressed(_ sender: Any) {
        
        
        //  showLoginError(messagetext: "Регистрация будет доступна в след. версиях")
    }
    
    @IBAction func nextWindow(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MainTab")
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkResult = checkLogin()
        if !checkResult {showLoginError(messagetext: "Авторизуйтесь для работы с приложением")}
        return checkResult
    }
    
    /*   @IBAction func ButtonPressed(_ sender: Any) {
     
     checkLogin()
     }*/
    
    func checkLogin()-> Bool {
        guard let loginInput = Login2.text, let passwordInput = Password.text else {return false}
        
        if (loginInput == "")||(passwordInput == "") {
            return false
        } else{
            return true
        }
    }//func
    
    func showLoginError(messagetext: String){
        //добавляем обработку ошибок
        
        // Создаем контроллер
        let alert = UIAlertController(title: "Ошибка", message: messagetext, preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.Login2.becomeFirstResponder()}) //в handler добавили текстовое поле, чтобы на него сфокусироваться
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        // Показываем UIAlertController
        present(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var scrollView: UIScrollView!
    
    
}//class




