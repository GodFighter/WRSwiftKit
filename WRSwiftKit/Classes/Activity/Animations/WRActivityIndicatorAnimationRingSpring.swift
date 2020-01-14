//
//  WRActivityIndicatorAnimationSpringCircle.swift
//  WRSwiftUtilDemo
//
//  Created by 项辉 on 2020/1/12.
//  Copyright © 2020 xianghui. All rights reserved.
//

import UIKit

class WRActivityIndicatorAnimationRingSpring: WRActivityIndicatorAnimationDelegate {

    func setupAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    
        let duration: CFTimeInterval = 3

        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.beginTime = 0
        animateStrokeEnd.duration = CFTimeInterval(duration / 2.0)
        animateStrokeEnd.fromValue = 0
        animateStrokeEnd.toValue = 1
        animateStrokeEnd.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let animateStrokeStart = CABasicAnimation(keyPath: "strokeStart")
        animateStrokeStart.beginTime = CFTimeInterval(duration / 2.0)
        animateStrokeStart.duration = CFTimeInterval(duration / 2.0)
        animateStrokeStart.fromValue = 0
        animateStrokeStart.toValue = 1
        animateStrokeStart.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let animateRotation = CABasicAnimation(keyPath: "transform.rotation.z")
        animateRotation.fromValue = 0
        animateRotation.toValue = CGFloat.pi * 2
        animateRotation.timingFunction = CAMediaTimingFunction(name: .linear)
        animateRotation.repeatCount = Float.infinity
        
        let colors = [color.cgColor]
        let animateColors = CAKeyframeAnimation(keyPath: "strokeColor")
        animateColors.duration = CFTimeInterval(duration)
        animateColors.keyTimes = [0]
        animateColors.values = colors
        animateColors.repeatCount = Float.infinity

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animateStrokeEnd, animateStrokeStart, animateRotation, animateColors]
        animationGroup.duration = CFTimeInterval(duration)
        animationGroup.fillMode = CAMediaTimingFillMode.both
        animationGroup.isRemovedOnCompletion = false
        animationGroup.repeatCount = Float.infinity

        let ring = WRActivityIndicatorShape.ring.layerWith(size: CGSize(width: size.width, height: size.height), color: color)

        let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                           y: (layer.bounds.size.height - size.height) / 2,
                           width: size.width,
                           height: size.height)

        ring.frame = frame
        ring.add(animationGroup, forKey: "loading")

        layer.addSublayer(ring)

    }
}
