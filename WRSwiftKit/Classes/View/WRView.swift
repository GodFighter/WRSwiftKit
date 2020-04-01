//
//  WRView.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/1/14.
//

import UIKit

@objc public protocol WRViewProtocol{
}

@objc extension UIView : WRViewProtocol {
    
    public override var wr: WRViewExtension {
        return WRViewExtension(self)
    }
}

@objc public class WRViewExtension: WRObjectExtension{
    internal init(_ value: UIView){
        super.init(value)
        self.value = value
    }
    
    var _view: UIView? {
        return self.value as? UIView
    }
    
    
    /**拆切任意圆角*/
    /// - parameter corners: 圆角位置
    /// - parameter cornerRadius: 圆角半径
    @objc public func clipCorner(_ corners: UIRectCorner, cornerRadius: CGSize) {
        if let view = _view {
            let maskBezier = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: cornerRadius)
            let maskLayer = CAShapeLayer.init()
            maskLayer.frame = view.bounds
            maskLayer.path = maskBezier.cgPath
            view.layer.mask = maskLayer
        }
    }

}
