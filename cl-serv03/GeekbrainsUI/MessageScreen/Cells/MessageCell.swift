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
    
    var presenter = ImagePresenter()
    
    override func prepareForReuse() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showImage))
        
        avatar.addGestureRecognizer(tapGesture)
    }
    
    @objc func showImage(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ImageController")
        
        let origin = superview!.convert(avatar.frame, to: (UIApplication.shared.windows.first?.rootViewController as? UINavigationController)?.view)
        presenter.size = origin
        vc.transitioningDelegate = presenter
        (UIApplication.shared.windows.first?.rootViewController as? UINavigationController)?.topViewController?.present(vc, animated: true, completion: nil)
    }//func showImage
    
}// class MessageCell

class ImagePresenter: NSObject, UIViewControllerTransitioningDelegate {
    let animator = Animator()
    
    var size = CGRect.zero
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    }

class Animator: NSObject, UIViewControllerAnimatedTransitioning{
    var frame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        
        let initialFrame = frame
        let finalFrame = fromView?.frame
        
        let xScale = initialFrame.width/finalFrame!.width
        let yScale = initialFrame.height/finalFrame!.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScale, y: yScale)
        
        toView?.transform = scaleTransform
        toView?.center = CGPoint(x: frame.midX, y: frame.midY)
        toView?.clipsToBounds = true
        
        container.addSubview(toView!)
        container.bringSubviewToFront(toView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView?.transform = .identity
            toView?.center = CGPoint(x: finalFrame!.midX, y: finalFrame!.midY)
        }){ complete in transitionContext.completeTransition(true)
            
        }
    }
}
