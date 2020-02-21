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
        
        setupDefault(userLiked: 0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefault(userLiked: 0)
    }
    
    public func setLikeCount(likeCount:Int, userLiked:Int){
        self.likeCount = likeCount
        setupDefault(userLiked: userLiked)
    }
    
    private func setupDefault(userLiked: Int){
        
        // let img = UIImage(named: "dislike")
        /* let myButton = UIButton(type: UIButton.ButtonType.custom)
         myButton.frame = CGRect.init(x: 10, y: 10, width: 100, height: 45)
         myButton.setImage(img, for: .normal)
         //myButton.addTarget(self, action: #selector(self.buttonClicked(_:)), for: UIControl.Event.touchUpInside)
         addSubview(myButton) */
        
        //   setImage(UIImage(named: "suit.heart"), for: .normal)
        
        //     let image = UIImage(named: "name") as UIImage?
        //      self.frame = CGRect(100, 100, 100, 100)
        //      self.setImage(image, for: .normal)
        //self.view.addSubview(button)
        
        setTitle(String(describing: likeCount), for: .normal)
        if userLiked == 1 {
            self.liked = true
            tintColor = .red
        }else{
            self.liked = false
            tintColor = .gray
        }
        
        //     imageEdgeInsets = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
        //   imageView?.contentMode = .scaleAspectFit
    }
    
    private func setLiked(){
        animateLike(liked: liked)
        likeCount += 1
        //    setImage(UIImage(named: "like"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        tintColor = .red
    }
    
    private func disableLike(){
        animateLike(liked: liked)
        likeCount -= 1
        //       setImage(UIImage(named: "dislike"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        tintColor = .gray
    }
    
    func animateLike(liked: Bool){
        //  bounced-анимация увеличивает размер лайка при нажатии лайка и уменьшает при dislike
        var localScaleX: CGFloat = 1.0
        var localScaleY: CGFloat = 1.0
        
        if liked {
            localScaleX = 1.5
            localScaleY = 1.5
        } else{
            localScaleX = 0.75
            localScaleY = 0.75
        }
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: [],
            animations:{ self.transform = CGAffineTransform(scaleX: localScaleX, y: localScaleY)},
            completion: {_ in UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)}
                )
        })
    }// func animateLike
    
}//class LikeButton
