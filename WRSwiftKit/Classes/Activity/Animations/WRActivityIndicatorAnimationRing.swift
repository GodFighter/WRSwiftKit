//
//  WRActivityIndicatorAnimationCircle.swift
//  WRSwiftUtilDemo
//
//  Created by 项辉 on 2020/1/12.
//  Copyright © 2020 xianghui. All rights reserved.
//

import UIKit

class WRActivityIndicatorAnimationRing: WRActivityIndicatorAnimationDelegate {

    func setupAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        let duration: CFTimeInterval = 0.75

        //    Scale animation
//        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
//
//        scaleAnimation.keyTimes = [0, 0.5, 1]
//        scaleAnimation.values = [1, 0.6, 1]

        // Rotate animation
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")

        rotateAnimation.keyTimes = [0, 0.5, 1]
        rotateAnimation.values = [0, Double.pi, 2 * Double.pi]

        // Animation
        let animation = CAAnimationGroup()

        animation.animations = [rotateAnimation]
        #if swift(>=4.2)
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        #else
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        #endif
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        // Draw circle
        let circle = WRActivityIndicatorShape.ringThirdFour.layerWith(size: CGSize(width: size.width, height: size.height), color: color)
        let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                           y: (layer.bounds.size.height - size.height) / 2,
                           width: size.width,
                           height: size.height)

        circle.frame = frame
        circle.add(animation, forKey: "animation")
        layer.addSublayer(circle)
    }

}
