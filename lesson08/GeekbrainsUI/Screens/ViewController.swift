//
//  ViewController.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 23/11/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate //для фокусирования курсора на текстовое поле
{
    
    // текст вводимого логина в этом контроллере - Login2
    @IBOutlet weak var Login2: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let HideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(HideAction)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panRecognize(_:)))
        view.addGestureRecognizer(panGesture)
       // testAnimation()
    }
    
    var propertyAnimator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 1.0, dampingRatio: 1.0, animations:{})
    
    @objc func panRecognize(_ recognizer: UIPanGestureRecognizer){
        switch recognizer.state{
        case .began:
            propertyAnimator = UIViewPropertyAnimator(duration: 1.0, dampingRatio: 1.0, animations:{
                self.logo.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
            
        case .changed:
            let translation = recognizer.translation(in: self.view)
            propertyAnimator.fractionComplete = translation.y / 100
        case .ended:
            propertyAnimator.stopAnimation(true)
            propertyAnimator.addAnimations {
                self.logo.transform = .identity
            }
            propertyAnimator.startAnimation()
        default: break
        }
    }
    
    
    
    //функция для анимации
  
    
    func testAnimation() {
        

            }//test animation
    
    //функция, убирающая клавиатуру с экрана при нажатии вне текстового поля
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    
    @IBAction func RegPressed(_ sender: Any) {
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
    

    @IBOutlet weak var animationShow: AnimationApple!
    
    @IBOutlet weak var animationShow2: AnimationApple!
    
    @IBAction func animationButtonPressed(_ sender: Any) {
        if animationShow.isHidden == true{
            animationShow.isHidden = false
            animationShow2.isHidden = false
        } else{
            animationShow.isHidden = true
            animationShow2.isHidden = true
        }
    }
}//class
