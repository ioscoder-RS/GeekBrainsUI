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

/// Used for ViewControllers that need to present an activity indicator when loading data.
public protocol ActivityIndicatorPresenter {

    /// The activity indicator
    var activityIndicator: UIActivityIndicatorView { get }

    /// Show the activity indicator in the view
    func showActivityIndicator()

    /// Hide the activity indicator in the view
    func hideActivityIndicator()
}// protocol ActivityIndicatorPresenter

public extension ActivityIndicatorPresenter where Self: UIViewController {

    func showActivityIndicator() {
        DispatchQueue.main.async {

            self.activityIndicator.style = UIActivityIndicatorView.Style.large
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80) //or whatever size you would like
            self.activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}//public extension ActivityIndicatorPresenter

class VKLoginController: UIViewController, ActivityIndicatorPresenter {
    var activityIndicator = UIActivityIndicatorView()
    
    let VKSecret = "7281379"
    var webView: WKWebView!
    var vkAPI = VKAPi()
    typealias Out = Swift.Result
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         showActivityIndicator()
        doWebConnect{
            result in
            self.hideActivityIndicator()
        }
         

    }//override func viewDidLoad()
    
    private func transitionToTabBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MainTab")
        vc.modalPresentationStyle = .custom
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func doWebConnect(completion: @escaping (Out<WKNavigation?,Error>)-> Void){
              let webViewConfig = WKWebViewConfiguration()
              webView = WKWebView(frame: .zero, configuration: webViewConfig)
              //              self.view = webView
        
              
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
              
              //информирует, что пользователь переходит на другую страницу, напр. с токеном
                webView.navigationDelegate = self
                view.addSubview(webView)
      
            let request = try URLRequest(url: urlComponent.url!)
          do {
              let loadResult = try webView.load(request)
            completion(.success(loadResult))
        }catch{
            completion(.failure(error))
        }
    }
}// class VKLoginController: UIViewController


extension VKLoginController: WKNavigationDelegate {
    //Функция возвращает текст ошибки, если она случается. Для отладки
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
        

        
        //Получение групп по поисковому запросу"
        //    vkAPI.searchGroups(token: Session.shared.token, query: "любовь")
        
        decisionHandler(.cancel)
        transitionToTabBar()
        
    }
}// extension

