//
//  WRActivityIndicator.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/1/14.
//

import UIKit

private struct wr_activityIndicator_associated{
   static var key = "wr_activityIndicator_associated_key"
}

@objc public protocol WRActivityIndicatorProtocol {
    @objc var indicator : WRActivityIndicatorManager { get }
}

@objc extension UIView : WRActivityIndicatorProtocol {
    @objc public var indicator : WRActivityIndicatorManager {
        let object = objc_getAssociatedObject(self, &wr_activityIndicator_associated.key)
        
        guard let activityIndicator = object as? WRActivityIndicatorManager else {
            let activityIndicator = WRActivityIndicatorManager(self)
            objc_setAssociatedObject(self, &wr_activityIndicator_associated.key, activityIndicator, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return activityIndicator
            
        }

        return activityIndicator
    }
}

@objc public class WRActivityIndicatorManager : NSObject {
    fileprivate var value : UIView
    fileprivate init(_ value : UIView) {
        self.value = value
    }

     fileprivate enum State: WRActivityIndicatorManagerState {
         case waitingToStart
         case animating
         case waitingToStop
         case stopped

         var performer: WRActivityIndicatorManagerState {
             switch self {
             case .waitingToStart: return WRActivityIndicatorManagerStateWaitingToStart()
             case .animating: return WRActivityIndicatorManagerStateAnimating()
             case .waitingToStop: return WRActivityIndicatorManagerStateWaitingToStop()
             case .stopped: return WRActivityIndicatorManagerStateStopped()
             }
         }

         func startAnimating(manager: WRActivityIndicatorManager, _ fadeInAnimation: WRFadeInAnimation?) {
             performer.startAnimating(manager: manager, fadeInAnimation)
         }

         func stopAnimating(manager: WRActivityIndicatorManager, _ fadeOutAnimation: WRFadeOutAnimation?) {
             performer.stopAnimating(manager: manager, fadeOutAnimation)
         }
     }
     
     private let messageLabel: UILabel = {
         let label = UILabel()

         label.textAlignment = .center
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false

         return label
     }()
         
     fileprivate let restorationIdentifier = "WRActivityIndicatorViewContainer"

     fileprivate var state: State = .stopped
     fileprivate var data: WRActivityData? // Shared activity data across states
     fileprivate let waitingToStartGroup = DispatchGroup()
          
     fileprivate final func startAnimating(_ data: WRActivityData, _ fadeInAnimation: WRFadeInAnimation? = nil) {
         self.data = data
         state.startAnimating(manager: self, fadeInAnimation ?? WRActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION)
     }

     // MARK: Helpers
     fileprivate func show(with activityData: WRActivityData, _ fadeInAnimation: WRFadeInAnimation?){
         let containerView = UIView(frame: UIScreen.main.bounds)
         containerView.backgroundColor = activityData.backgroundColor
         containerView.restorationIdentifier = restorationIdentifier
         containerView.translatesAutoresizingMaskIntoConstraints = false
         fadeInAnimation?(containerView)

         let activityIndicatorView = WRActivityIndicatorView(
            frame: CGRect(x: 0, y: 0, width: activityData.size.width, height: activityData.size.height),
            type: activityData.type,
            color: activityData.color,
            padding: activityData.padding)

         activityIndicatorView.startAnimating()
         activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
         containerView.addSubview(activityIndicatorView)

             // Add constraints for `activityIndicatorView`.
             ({
                 let xConstraint = NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: activityIndicatorView, attribute: .centerX, multiplier: 1, constant: 0)
                 let yConstraint = NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: activityIndicatorView, attribute: .centerY, multiplier: 1, constant: 0)

                 containerView.addConstraints([xConstraint, yConstraint])
                 }())

             
         messageLabel.font = activityData.messageFont
         messageLabel.textColor = activityData.textColor
         messageLabel.text = activityData.message
         containerView.addSubview(messageLabel)

         // Add constraints for `messageLabel`.
         ({
             let leadingConstraint = NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: messageLabel, attribute: .leading, multiplier: 1, constant: -8)
             let trailingConstraint = NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: messageLabel, attribute: .trailing, multiplier: 1, constant: 8)
                
             containerView.addConstraints([leadingConstraint, trailingConstraint])
             }())
         ({
                 
             let spacingConstraint = NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: activityIndicatorView, attribute: .bottom, multiplier: 1, constant: activityData.messageSpacing)
             containerView.addConstraint(spacingConstraint)
                 }())
            
        let keyWindow = self.value
             
         keyWindow.addSubview(containerView)
            
         // Add constraints for `containerView`.
         ({
             let leadingConstraint = NSLayoutConstraint(item: keyWindow, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0)
             let trailingConstraint = NSLayoutConstraint(item: keyWindow, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0)
             let topConstraint = NSLayoutConstraint(item: keyWindow, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0)
             let bottomConstraint = NSLayoutConstraint(item: keyWindow, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0)
                 
             keyWindow.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
             }())
     }


    fileprivate func hide(_ fadeOutAnimation: WRFadeOutAnimation?) {
        for item in self.value.subviews where item.restorationIdentifier == restorationIdentifier {
              if let fadeOutAnimation = fadeOutAnimation {
                  fadeOutAnimation(item) {
                      item.removeFromSuperview()
                  }
              } else {
                item.removeFromSuperview()
            }
        }
     }

}

//MARK:-
fileprivate typealias WRActivityIndicatorManager_Public = WRActivityIndicatorManager
extension WRActivityIndicatorManager_Public {
    
    /**是否正在动画中*/
    @objc public var isAnimating: Bool { return state == .animating || state == .waitingToStop }

    /**开始*/
    /**
    因为type、size、padding参数在OC中不能不展示
    */
    /// - parameter type: 活动指示器动画类型
    /// - parameter size: 尺寸
    /// - parameter padding: 内边距
    /// - parameter message: 展示消息
    /// - parameter messageFont: 消息字体
    /// - parameter color: 动画颜色
    /// - parameter backgroundColor: 背景颜色
    /// - parameter textColor: 文本颜色
    /// - parameter fadeInAnimation: 进入动画
    @objc public final func startAnimating(
         //@available(*, unavailable) @objc public final func startAnimating(
         _ type: WRActivityIndicatorType,
         size: CGSize,
         padding: CGFloat,
         message: String? = nil,
         messageFont: UIFont? = nil,
         color: UIColor? = nil,
         backgroundColor: UIColor? = nil,
         textColor: UIColor? = nil,
         fadeInAnimation: WRFadeInAnimation? = WRActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION) {
         let activityData = WRActivityData(size: size,
                                         message: message,
                                         messageFont: messageFont,
                                         type: type,
                                         color: color,
                                         padding: padding,
                                         backgroundColor: backgroundColor,
                                         textColor: textColor)

         self.startAnimating(activityData, fadeInAnimation)
     }
    
    /**开始*/
    /**
    此方法针对Swift开放
    */
    /// - parameter type: 活动指示器动画类型
    /// - parameter size: 尺寸
    /// - parameter padding: 内边距
    /// - parameter message: 展示消息
    /// - parameter messageFont: 消息字体
    /// - parameter color: 动画颜色
    /// - parameter backgroundColor: 背景颜色
    /// - parameter textColor: 文本颜色
    /// - parameter fadeInAnimation: 进入动画
    public final func startAnimating(
        _ type: WRActivityIndicatorType? = nil,
        size: CGSize? = nil,
        padding: CGFloat? = nil,
        message: String? = nil,
        messageFont: UIFont? = nil,
        color: UIColor? = nil,
        backgroundColor: UIColor? = nil,
        textColor: UIColor? = nil,
        fadeInAnimation: WRFadeInAnimation? = WRActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION) {
        let activityData = WRActivityData(size: size,
                                        message: message,
                                        messageFont: messageFont,
                                        type: type,
                                        color: color,
                                        padding: padding,
                                        backgroundColor: backgroundColor,
                                        textColor: textColor)

        self.startAnimating(activityData, fadeInAnimation)
    }

    /**结束动画*/
    /**
    动画结束后，视图会从父视图中移除
    */
    /// - parameter WRFadeOutAnimation: 离开动画
    @objc public final func stopAnimating(_ fadeOutAnimation: WRFadeOutAnimation? = nil) {
        state.stopAnimating(manager: self, fadeOutAnimation ?? WRActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
    }

    /**设置展示文本*/
    /// - parameter message: 文本内容
    @objc public final func setMessage(_ message: String?) {
        waitingToStartGroup.notify(queue: DispatchQueue.main) {
            self.messageLabel.text = message
        }
    }

}



//MARK:-
fileprivate final class WRActivityData {
    /// Size of activity indicator view.
    let size: CGSize

    /// Message displayed under activity indicator view.
    let message: String?

    /// Font of message displayed under activity indicator view.
    let messageFont: UIFont

    /// Message spacing to activity indicator view.
    let messageSpacing: CGFloat

    /// Animation type.
    let type: WRActivityIndicatorType

    /// Color of activity indicator view.
    let color: UIColor

    /// Color of text.
    let textColor: UIColor

    /// Padding of activity indicator view.
    let padding: CGFloat

    /// Background color of the UI blocker
    let backgroundColor: UIColor

    fileprivate init(size: CGSize? = nil,
                message: String? = nil,
                messageFont: UIFont? = nil,
                messageSpacing: CGFloat? = nil,
                type: WRActivityIndicatorType? = nil,
                color: UIColor? = nil,
                padding: CGFloat? = nil,
                backgroundColor: UIColor? = nil,
                textColor: UIColor? = nil) {
        self.size = size ?? WRActivityIndicatorView.DEFAULT_BLOCKER_SIZE
        self.message = message ?? WRActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE
        self.messageFont = messageFont ?? WRActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_FONT
        self.messageSpacing = messageSpacing ?? WRActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_SPACING
        self.type = type ?? WRActivityIndicatorView.DEFAULT_TYPE
        self.color = color ?? WRActivityIndicatorView.DEFAULT_COLOR
        self.padding = padding ?? WRActivityIndicatorView.DEFAULT_PADDING


        self.backgroundColor = backgroundColor ?? WRActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR
        self.textColor = textColor ?? color ?? WRActivityIndicatorView.DEFAULT_TEXT_COLOR
    }
}

//MARK:- WRActivityIndicatorManagerState Protocol
private protocol WRActivityIndicatorManagerState {
    func startAnimating(manager: WRActivityIndicatorManager, _ fadeInAnimation: WRFadeInAnimation?)
    func stopAnimating(manager: WRActivityIndicatorManager, _ fadeOutAnimation: WRFadeOutAnimation?)
}

private struct WRActivityIndicatorManagerStateWaitingToStart: WRActivityIndicatorManagerState {
    func startAnimating(manager: WRActivityIndicatorManager, _ fadeInAnimation: WRFadeInAnimation?) {
        guard let activityData = manager.data else { return }

        manager.show(with: activityData, fadeInAnimation)
        manager.state = .animating
        manager.waitingToStartGroup.leave()
    }

    func stopAnimating(manager: WRActivityIndicatorManager, _ fadeOutAnimation: WRFadeOutAnimation?) {
        manager.state = .stopped
        manager.waitingToStartGroup.leave()
    }
}

private struct WRActivityIndicatorManagerStateAnimating: WRActivityIndicatorManagerState {
    func startAnimating(manager: WRActivityIndicatorManager, _ fadeInAnimation: WRFadeInAnimation?) {
        
    }
    
    func stopAnimating(manager: WRActivityIndicatorManager, _ fadeOutAnimation: WRFadeOutAnimation?) {
        guard let _ = manager.data else { return }

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(0)) {
            guard manager.state == .waitingToStop else { return }

            manager.stopAnimating(fadeOutAnimation)
        }
        manager.state = .waitingToStop
    }
    
}

private struct WRActivityIndicatorManagerStateWaitingToStop: WRActivityIndicatorManagerState {
    func startAnimating(manager: WRActivityIndicatorManager, _ fadeInAnimation: WRFadeInAnimation?) {
        manager.stopAnimating(nil)

        guard let activityData = manager.data else { return }
        manager.startAnimating(activityData, fadeInAnimation)
    }
    
    func stopAnimating(manager: WRActivityIndicatorManager, _ fadeOutAnimation: WRFadeOutAnimation?) {
        manager.hide(fadeOutAnimation)
        manager.state = .stopped
    }
}

private struct WRActivityIndicatorManagerStateStopped: WRActivityIndicatorManagerState {
    func startAnimating(manager: WRActivityIndicatorManager, _ fadeInAnimation: WRFadeInAnimation?) {
        guard let activityData = manager.data else { return }

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(0)) {
            guard manager.state == .waitingToStart else { return }

            manager.startAnimating(activityData, fadeInAnimation)
        }
        manager.state = .waitingToStart
        manager.waitingToStartGroup.enter()
    }
    
    func stopAnimating(manager: WRActivityIndicatorManager, _ fadeOutAnimation: WRFadeOutAnimation?) {
        
    }
}
