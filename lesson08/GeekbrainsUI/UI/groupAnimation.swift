//
//  groupAnimation.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 20/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit

class groupAnimation:UIView{
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(roundedRect:  CGRect(x: 0, y: 0, width: 50, height: 50) , cornerRadius: 35).cgPath

        circleLayer.strokeColor = UIColor.green.cgColor
              circleLayer.backgroundColor = UIColor.systemTeal.cgColor
             circleLayer.lineWidth = 3
        layer.addSublayer(circleLayer)
        
        
        
        
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
        
        circleLayer.add(groupAnimation, forKey: nil)
    }//draw
    
}//class groupAnimation:UIView{
