//
//  MessageCell.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 13/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var message: UILabel!
    

    @IBAction func likeButtonPressed(_ sender: Any) {
        (sender as! LikeButton).like()

    }
    
    @IBAction func commentButtonPressed(_ sender: Any) {
        (sender as! CustomCommentButton).comment()

    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        (sender as! CustomShareButton).share()
    }
    
    @IBAction func viewedButtonPressed(_ sender: Any) {
       (sender as! CustomViewButton).setLook()
    }
}
