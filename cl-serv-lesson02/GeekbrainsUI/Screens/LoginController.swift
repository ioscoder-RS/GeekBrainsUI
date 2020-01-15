//
//  LoginController.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 14/01/2020.
//  Copyright © 2020 raskin-sa. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

private let debugMode = 0 //1 - debug on, 0 - debug off

class VKLoginController: UIViewController {
    let VKSecret = "7281379"
    
    @IBOutlet weak var webView: WKWebView!
    
    var vkAPI = VKAPi()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        let webViewConfig = WKWebViewConfiguration()
              webView = WKWebView(frame: .zero, configuration: webViewConfig)
                self.view = webView
              //информирует, что пользователь переходит на другую страницу, напр. с токеном
              webView.navigationDelegate = self
              
              var urlComponent = URLComponents()
              urlComponent.scheme = "https"
              urlComponent.host = "oauth.vk.com"
              urlComponent.path = "/authorize"
              urlComponent.queryItems = [URLQueryItem(name: "client_id", value: VKSecret),
                                         URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/authorize/blank.html"),
                                         URLQueryItem(name: "display", value: "mobile"),
                                         URLQueryItem(name: "scope", value: "262150"),
                                         URLQueryItem(name: "response_type", value: "token"),
                                         URLQueryItem(name: "v", value: "5.103")
              ]

              let request = URLRequest(url: urlComponent.url!)
              webView.load(request)
     
    }
}

//Функция возвращает текст ошибки, если она случается. Для отладки
extension VKLoginController: WKNavigationDelegate {
  func webView(_ webView: WKWebView,
    didFailProvisionalNavigation navigation: WKNavigation!, 
    withError error: Error) {
 
    if debugMode == 1 {print(error)}
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
   
        if debugMode == 1 {
        if let response = navigationResponse.response as? HTTPURLResponse {
           print("response description = \(response.description)")
               print("response.statusCode = \(response.statusCode)")
            
        }
        }
        
        
        guard let url = navigationResponse.response.url,
        url.path == "/blank.html",
            let fragment = url.fragment else {
                decisionHandler(.allow)
                return
        }
        
        let params = fragment.components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()) {
                value, params in
                var dict = value
                let key = params[0]
                let value = params[1]
                dict[key] = value
                return dict
        }
        if debugMode == 1 {print(params)}
        
        Session.shared.token = params["access_token"]!
        Session.shared.userId = params["user_id"] ?? "0"
        
      //Получение списка друзей
        vkAPI.getFriendList(token: Session.shared.token)
       
     //Получение фотографий человека
        vkAPI.getPhotosList(token: Session.shared.token, userId: Session.shared.userId)
   //     vkAPI.getPhotosList(token: Session.shared.token, userId: "3473904")
        
       //Получение групп текущего пользователя
        vkAPI.getGroupsList(token: Session.shared.token, userId: Session.shared.userId)
        
        //Получение групп по поисковому запросу"
        vkAPI.searchGroups(token: Session.shared.token, query: "любовь")
        
        decisionHandler(.cancel)
    }
}// extension

