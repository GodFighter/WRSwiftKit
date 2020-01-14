//
//  WRBaseViewController.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/1/14.
//

import UIKit

@objc open class WRBaseViewController: UIViewController {

    @objc deinit{
        debugPrint("deinit:\(self.classForCoder)")
    }

    @objc public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @objc required public init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    @objc open override func viewDidLoad() {
        super.viewDidLoad()
        //默认去除返回按钮标题
        self.setNaviBackTitle("")
        debugPrint("viewDidLoad:\(self.classForCoder)")
    }
        
    @objc open override var prefersStatusBarHidden : Bool {
        return WRConfigStyle.StatusBar.isHidden
    }
        
    @objc open override var preferredStatusBarStyle : UIStatusBarStyle {
        return WRConfigStyle.StatusBar.barStyle
    }
        
    @objc open override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return WRConfigStyle.StatusBar.updateAnimation
    }
        
    @objc open  func topViewController() -> UIViewController?{
        
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController{
            return self.topViewControllerWithRootViewController(rootViewController: rootViewController)
        }
        return nil
    }
        
    @objc open  func topViewControllerWithRootViewController(rootViewController : UIViewController) -> UIViewController{
        
        if let tabBarController = rootViewController as? UITabBarController, let selectedViewController = tabBarController.selectedViewController{
            return self.topViewControllerWithRootViewController(rootViewController: selectedViewController)
        }
        else if let navigationController = rootViewController as? UINavigationController, let visibleViewController = navigationController.visibleViewController{
            return self.topViewControllerWithRootViewController(rootViewController: visibleViewController)
            
        }
        else if let presentedViewController = rootViewController.presentedViewController{
            return self.topViewControllerWithRootViewController(rootViewController: presentedViewController)
        }
        else{
            return rootViewController
        }
    }
    
    @objc open override var shouldAutorotate : Bool {
        return true
    }
    
    @objc open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIDevice.current.userInterfaceIdiom == .pad ? .all : .portrait
    }

}
