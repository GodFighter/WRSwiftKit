//
//  WRNavigationController.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/1/14.
//

import UIKit

@objc public class WRNavigationController: UINavigationController {

    @objc public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @objc public override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: WRNavigationBar.classForCoder(), toolbarClass: nil)
        self.viewControllers = [rootViewController]
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        WRConfigStyle.NavigationBar.reset(self.navigationBar)
    }
    
    @objc public override var prefersStatusBarHidden : Bool {
        return self.topViewController?.prefersStatusBarHidden ?? WRConfigStyle.StatusBar.isHidden
    }
    
    @objc public override var preferredStatusBarStyle : UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? WRConfigStyle.StatusBar.barStyle
    }
    
    @objc public override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return self.topViewController?.preferredStatusBarUpdateAnimation ?? WRConfigStyle.StatusBar.updateAnimation
    }
    
    @objc open override var shouldAutorotate : Bool {
        return self.topViewController?.shouldAutorotate ?? super.shouldAutorotate
    }
    
    @objc open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return self.topViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    @objc override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }

}
