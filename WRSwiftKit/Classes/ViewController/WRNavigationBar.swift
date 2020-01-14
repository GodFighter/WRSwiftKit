//
//  WRNavigationBar.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/1/14.
//

import UIKit

//MARK: -
@objc public protocol WRNavigationBarProtocol {

}

@objc extension UIViewController : WRNavigationBarProtocol {
    //MARK: Config
    @objc public var naviBarBackgroundView : UIView? {
        return (self.navigationController?.navigationBar as? WRNavigationBar)?.backgroundView
    }
    
    @objc public var naviBarBackgroundImageView : UIImageView? {
        return (self.navigationController?.navigationBar as? WRNavigationBar)?.backgroundImageView
    }

    @objc public func setNaviBarImage(_ image: UIImage?){
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
    }

    @objc public func setNaviBarColor(_ barColor: UIColor?){
        self.navigationController?.navigationBar.barTintColor = barColor
    }

    @objc public func setNaviTintColor(_ tintColor: UIColor){
        self.navigationController?.navigationBar.tintColor = tintColor
    }
    
    @objc public func setNaviTitleColor(_ titleColor: UIColor){
        
        var titleTextAttributes: [NSAttributedString.Key : AnyObject] =  [NSAttributedString.Key : AnyObject]()
        titleTextAttributes[NSAttributedString.Key.foregroundColor] = titleColor
        
        if #available(iOS 8.2, *) {
            titleTextAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        } else {
            titleTextAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17)
            // Fallback on earlier versions
        }
        self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
    }
    
    @objc public func setNaviShadowColor(_ shadowColor: UIColor){
        self.navigationController?.navigationBar.shadowImage = UIImage.color(shadowColor, size: CGSize(width: UIScreen.main.bounds.width, height: 1))    }
    
    @objc public func setNaviBarTitleColor(_ tintColor: UIColor, titleColor: UIColor, shadowColor: UIColor? = nil){
        self.setNaviBarColor(tintColor)
        self.setNaviTitleColor(titleColor)
        if let shadowColor = shadowColor{
            self.setNaviShadowColor(shadowColor)
        }
    }

    //MARK: BackTitle
    @discardableResult
    @objc public func setNaviBackTitle(_ title: String) -> UIBarButtonItem{
        let titleItem = UIBarButtonItem(title: title, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = titleItem
        return titleItem
    }
    
    @discardableResult
    @objc public func setNaviBackTitle(_ title: String, color: UIColor) -> UIBarButtonItem{
        let titleItem = UIBarButtonItem(title: title, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        titleItem.tintColor = color
        self.navigationItem.backBarButtonItem = titleItem
        return titleItem
    }
    
    @discardableResult
    @objc public func setNaviBackTitle(_ title: String, color: UIColor, image : UIImage?) -> UIBarButtonItem{
        
        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        
        let titleItem = UIBarButtonItem(title: title, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        titleItem.tintColor = color
        self.navigationItem.backBarButtonItem = titleItem
        return titleItem
    }

    //MARK: Item
    @discardableResult
    @objc public func setNaviLeftItem(_ title : String, attributes: [NSAttributedString.Key : Any]? = nil, target: Any?, selector: Selector?) -> UIBarButtonItem{
        let barButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        barButtonItem.tintColor = UIColor.color(fromHexString: "333333")
        barButtonItem.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.leftBarButtonItem = barButtonItem
        return barButtonItem
    }
    
    @discardableResult
    @objc public func setNaviRightItem(_ title : String, attributes: [NSAttributedString.Key : Any]? = nil, target: Any?, selector: Selector?) -> UIBarButtonItem{
        let barButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        barButtonItem.tintColor = UIColor.color(fromHexString: "333333")
        barButtonItem.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.rightBarButtonItem = barButtonItem
        return barButtonItem
    }

}

@objc public class WRConfigStyle : NSObject {
    @objc public class StatusBar : NSObject {
        @objc public static var isHidden : Bool = false
        @objc public static var barStyle : UIStatusBarStyle = UIStatusBarStyle.lightContent
        @objc public static var updateAnimation : UIStatusBarAnimation = UIStatusBarAnimation.slide
    }
    
    @objc public class NavigationBar : NSObject {
        
        @objc public static var tintColor : UIColor = .white                               //按钮颜色
        @objc public static var shadowColor : UIColor = .clear                             //阴影颜色
        @objc public static var barTintColor : UIColor? = nil                              //背景颜色
        @objc public static var backImage : UIImage? = UIImage(named: "navigationBar_Back")    //返回图标
        @objc public static var backColor : UIColor = .white                               //返回颜色

        @objc public static var barTintImage : UIImage? = {                                //背景图片
            let colors : [UIColor] = [UIColor.color(fromHexString: "#333333"), UIColor.color(fromHexString: "#111111")]
            return UIImage.color(colors: colors, size: CGSize(width: UIScreen.main.bounds.width, height: 64), locations: [0.0 , 1.0], start: CGPoint(x:0.5, y: 0.0), end: CGPoint(x:1.0, y: 1.0))
            }()
        
        @objc public static var backTitleAttributes : [NSAttributedString.Key : Any] = {    //返回字体
            return [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]
        }()

        @objc public static func customBarTintImage(_ beginColor : UIColor, endColor : UIColor) -> () {
            let colors : [UIColor] = [beginColor, endColor]
            WRConfigStyle.NavigationBar.barTintImage = UIImage.color(colors: colors, size: CGSize(width: UIScreen.main.bounds.width, height: 64), locations: [0.0 , 1.0], start: CGPoint(x:0.5, y: 0.0), end: CGPoint(x:1.0, y: 1.0))
        }

        @objc public static func customBarTintImage(_ image : UIImage?) -> () {
            if image != nil {
                WRConfigStyle.NavigationBar.barTintImage = image
            }
        }

        @objc public static var titleAttributes : [NSAttributedString.Key : Any] = {        //标题属性
            return [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),
                    NSAttributedString.Key.foregroundColor : WRConfigStyle.NavigationBar.tintColor]
        }()


        @objc public static func addPopAnimation(_ navigationController : UINavigationController?){
            
            let transition = CATransition()
            transition.duration = 0.35
            transition.type = CATransitionType(rawValue: "reveal")
            transition.subtype = CATransitionSubtype.fromLeft
            navigationController?.view.layer.add(transition, forKey: nil)
        }
        
        @objc public static func addPushAnimation(_ navigationController : UINavigationController?){
            
            let transition = CATransition()
            transition.duration = 0.35
            transition.type = CATransitionType(rawValue: "moveIn")
            transition.subtype = CATransitionSubtype.fromRight
            navigationController?.view.layer.add(transition, forKey: nil)
        }
        
        @objc public static func reset(_ navigationBar: UINavigationBar?){
            
            navigationBar?.isTranslucent = true
            
            navigationBar?.tintColor = WRConfigStyle.NavigationBar.tintColor
            
            navigationBar?.titleTextAttributes = WRConfigStyle.NavigationBar.titleAttributes
            
            
            navigationBar?.barTintColor = nil
            
            navigationBar?.backgroundColor = nil
            
            navigationBar?.setBackgroundImage(UIImage(), for: .default)
            
            (navigationBar as? WRNavigationBar)?.backgroundView.alpha = 1.0
            (navigationBar as? WRNavigationBar)?.backgroundImageView.alpha = 1.0
            (navigationBar as? WRNavigationBar)?.backgroundImageView.image = WRConfigStyle.NavigationBar.barTintImage
            
            navigationBar?.shadowImage = UIImage.color(WRConfigStyle.NavigationBar.shadowColor, size: CGSize(width: UIScreen.main.bounds.width, height: 1))
            
            navigationBar?.backIndicatorImage = WRConfigStyle.NavigationBar.backImage
            
            navigationBar?.backIndicatorTransitionMaskImage = WRConfigStyle.NavigationBar.backImage
            
            UIBarButtonItem.appearance().setTitleTextAttributes(WRConfigStyle.NavigationBar.backTitleAttributes, for: .normal)
            
        }
        
        @objc public static func setTransparent(_ navigationBar: UINavigationBar?){
            
            navigationBar?.isTranslucent = true
            navigationBar?.barTintColor = nil
            navigationBar?.backgroundColor = nil
            navigationBar?.shadowImage = UIImage()
            navigationBar?.setBackgroundImage(UIImage(), for: .default)
            
            (navigationBar as? WRNavigationBar)?.backgroundView.alpha = 1.0
            (navigationBar as? WRNavigationBar)?.backgroundImageView.alpha = 1.0
            (navigationBar as? WRNavigationBar)?.backgroundImageView.image = nil
        }

    }
}


//MARK: -
@objc public class WRNavigationBar : UINavigationBar{
    
    public var backgroundView : UIView = UIView()
    
    public var backgroundImageView : UIImageView = UIImageView()
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = nil
        
        self.backgroundView.frame = CGRect(x: 0,
                                           y: -UIApplication.shared.statusBarFrame.height,
                                           width: self.frame.width,
                                           height: self.frame.height + UIApplication.shared.statusBarFrame.height)
        
        self.backgroundView.isUserInteractionEnabled = false
        
        self.backgroundView.backgroundColor = nil
        self.backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.backgroundImageView.backgroundColor = nil
        self.backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.backgroundImageView.frame = CGRect(origin: .zero, size: self.backgroundView.frame.size)
        self.backgroundView.addSubview(self.backgroundImageView)
        
        self.addSubview(self.backgroundView)
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.sendSubviewToBack(self.backgroundView)
    }
    
}
