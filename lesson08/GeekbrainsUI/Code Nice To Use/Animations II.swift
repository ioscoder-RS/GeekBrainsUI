//
//  Animations II.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 18/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

//KeyFrame animations
UIView.animateKeyframes(withDuration: 3.0, delay: 0,  animations: { UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33){
    self.logo.center.x += 100
}
    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33){
        self.logo.center.x += 100
    }
    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33){
            self.logo.center.x += 100
        }
        }, completion: nil)

     ///
        ///Stroke Animations = закрашивает контуры
    ///

       let strokeAnimationStart = CABasicAnimation(keyPath: "strokeStart")
       strokeAnimationStart.fromValue = 0
       strokeAnimationStart.toValue = 1.0
       
       let strokeAnimationEnd = CABasicAnimation(keyPath: "strokeEnd")
       strokeAnimationEnd.fromValue = 0
       strokeAnimationEnd.toValue = 1.2
       
       let groupAnimation = CAAnimationGroup()
       groupAnimation.duration = 1.0
       groupAnimation.animations = [strokeAnimationStart, strokeAnimationEnd]
       groupAnimation.autoreverses = true
       groupAnimation.repeatCount = .infinity
       groupAnimation.isRemovedOnCompletion = false
       groupAnimation.fillMode = .forwards
       
       customLayer.add(groupAnimation, forKey: nil)

