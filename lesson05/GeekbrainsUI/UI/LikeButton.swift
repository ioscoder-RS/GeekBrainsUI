//
//  LikeButton.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 08/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit
class LikeButton: UIButton{
   var liked:Bool = false
    var likeCount = 0
    
    func like(){
       liked = !liked
        
    if liked{
        setLiked()
    } else {
        disableLike()
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefault()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefault()
    }
    
    private func setupDefault(){
  //      setImage(UIImage(named: "like"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        tintColor = .gray
   //     imageEdgeInsets = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
     //   imageView?.contentMode = .scaleAspectFit
    }
    
    private func setLiked(){
        likeCount += 1
    //    setImage(UIImage(named: "like"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
         tintColor = .red
    }
    
    private func disableLike(){
        likeCount -= 1
 //       setImage(UIImage(named: "dislike"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
         tintColor = .gray
    }
}//class LikeButton
