//
//  CircleTransition.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 21/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit

class CircularTransition: NSObject, UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let from = transitionContext.viewController(forKey: .from),
            let to = transitionContext.viewController(forKey: .to) else{
                return
        }
        let backView = UIView()
        backView.frame = to.view.frame
        backView.backgroundColor = from.view.backgroundColor
        transitionContext.containerView.addSubview(backView)
        
        transitionContext.containerView.addSubview(to.view)
        
        let buttonFrom = (from as! LoginViewController).startButton!
        
        let startRect = CGRect(x: buttonFrom.center.x,
                               y: buttonFrom.center.y,
                               width: buttonFrom.frame.width,
                               height: buttonFrom.frame.height)
        let circleBezier = UIBezierPath(ovalIn: startRect)
        
        let finalBezier = UIBezierPath(ovalIn: buttonFrom.frame.insetBy(dx: -1000, dy: -1000))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = finalBezier.cgPath
        to.view.layer.mask = maskLayer
        
        let circleAnimation = CABasicAnimation(keyPath: "path")
        circleAnimation.fromValue = circleBezier.cgPath
        circleAnimation.duration = 2.0
        circleAnimation.toValue = finalBezier.cgPath
        maskLayer.add(circleAnimation, forKey: nil)
    }
}
