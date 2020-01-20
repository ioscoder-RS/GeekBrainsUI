//
//  FriendsPhotoViewController.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 27/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit

class FriendsPhotoViewController : UIViewController {
    
    @IBOutlet weak var friendPhotolikeButton: LikeButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var friendPhoto: UIImageView!
    
 //  public var friend : Friend?
//**    public var friend : VKUser?
    public var indexImage: Int?
    public var indexText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let indexImage = self.indexImage else{return}
        guard let indexText = self.indexText else{return}
        
     
        if UIImage(named: "\(indexImage).jpg") != nil{
            friendPhoto.image = UIImage(named: "\(indexImage).jpg")
      } else{
                friendPhoto.image = UIImage(named: "NewUser.jpg")
           }
          username.text = indexText
     
    }// viewDidLoad
    
    @IBAction func likeButtonPressed(_ sender: Any) {
         (sender as! LikeButton).like()
    }
    
}// class FriendsPhotoViewController

