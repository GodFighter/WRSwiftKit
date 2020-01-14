//
//  WRActivityIndicatorView.swift
//  WRSwiftUtilDemo
//
//  Created by 项辉 on 2020/1/12.
//  Copyright © 2020 xianghui. All rights reserved.
//

import UIKit

@objc public enum WRActivityIndicatorType: Int, CaseIterable {
    case system
    case ring
    case ringSpring
    case ballRotateChase
    case ballSpinFadeLoader
    case audioEqualizer

    func animation() -> WRActivityIndicatorAnimationDelegate {
        switch self {
            case .system:               return WRActivityIndicatorAnimationSystem()
            case .ring:                 return WRActivityIndicatorAnimationRing()
            case .ringSpring:           return WRActivityIndicatorAnimationRingSpring()
            case .ballRotateChase:      return WRActivityIndicatorAnimationBallRotateChase()
            case .ballSpinFadeLoader:   return WRActivityIndicatorAnimationBallSpinFadeLoader()
            case .audioEqualizer:       return WRActivityIndicatorAnimationAudioEqualizer()
        }
    }
}

public typealias WRFadeInAnimation = (UIView) -> Void
public typealias WRFadeOutAnimation = (UIView, @escaping () -> Void) -> Void

public class WRActivityIndicatorView: UIView {

    //MARK:-  static property
    static var DEFAULT_TYPE: WRActivityIndicatorType = .system
    static var DEFAULT_COLOR = UIColor.white
    static var DEFAULT_TEXT_COLOR = UIColor.white
    static var DEFAULT_PADDING: CGFloat = 0
    static var DEFAULT_BLOCKER_SIZE = CGSize(width: 60, height: 60)
    static var DEFAULT_BLOCKER_MESSAGE: String?
    static var DEFAULT_BLOCKER_MESSAGE_SPACING = CGFloat(8.0)
    static var DEFAULT_BLOCKER_MESSAGE_FONT = UIFont.boldSystemFont(ofSize: 20)
    static var DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)

    public static var DEFAULT_FADE_IN_ANIMATION: WRFadeInAnimation = { view in
        view.alpha = 0
        UIView.animate(withDuration: 0.25) {
            view.alpha = 1
        }
    }

    public static var DEFAULT_FADE_OUT_ANIMATION: WRFadeOutAnimation = { (view, complete) in
        UIView.animate(withDuration: 0.25,
                       animations: {
                        view.alpha = 0
        },
                       completion: { completed in
                        if completed {
                            complete()
                        }
        })
    }
    
    //MARK:- property
    var type: WRActivityIndicatorType = WRActivityIndicatorView.DEFAULT_TYPE
    @IBInspectable var color: UIColor = WRActivityIndicatorView.DEFAULT_COLOR
    @IBInspectable var padding: CGFloat = WRActivityIndicatorView.DEFAULT_PADDING
    private(set) public var isAnimating: Bool = false

    //MARK:- life
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
        isHidden = true
    }

    init(frame: CGRect, type: WRActivityIndicatorType? = nil, color: UIColor? = nil, padding: CGFloat? = nil) {
        self.type = type ?? WRActivityIndicatorView.DEFAULT_TYPE
        self.color = color ?? WRActivityIndicatorView.DEFAULT_COLOR
        self.padding = padding ?? WRActivityIndicatorView.DEFAULT_PADDING
        super.init(frame: frame)
        isHidden = true
    }

    override public var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: bounds.height)
    }

    override public var bounds: CGRect {
        didSet {
            // setup the animation again for the new bounds
            if oldValue != bounds && isAnimating {
                setupAnimation()
            }
        }
    }

    final func startAnimating() {
        guard !isAnimating else {
            return
        }
        isHidden = false
        isAnimating = true
        layer.speed = 1
        setupAnimation()
    }

    final func stopAnimating() {
        guard isAnimating else {
            return
        }
        isHidden = true
        isAnimating = false
        layer.sublayers?.removeAll()
    }

    private final func setupAnimation() {
        let animation: WRActivityIndicatorAnimationDelegate = type.animation()
        #if swift(>=4.2)
        var animationRect = frame.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        #else
        var animationRect = UIEdgeInsetsInsetRect(frame, UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        #endif
        let minEdge = min(animationRect.width, animationRect.height)

        layer.sublayers = nil
        animationRect.size = CGSize(width: minEdge, height: minEdge)
        animation.setupAnimation(in: layer, size: animationRect.size, color: color)
    }

}