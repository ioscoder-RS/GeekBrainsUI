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
    
   public var friend : Friend?
//**    public var friend : VKUser?
    public var indexImage: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let indexImage = self.indexImage else{return}
        
     if let friend = self.friend {
        if UIImage(named: "\(friend.photoArray[indexImage]).jpg") != nil{
            friendPhoto.image = UIImage(named: "\(friend.photoArray[indexImage]).jpg")
      } else{
                friendPhoto.image = UIImage(named: "NewUser.jpg")
           }
          username.text = friend.userName
     }
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
         (sender as! LikeButton).like()
    }
    
}// class FriendsPhotoViewController

