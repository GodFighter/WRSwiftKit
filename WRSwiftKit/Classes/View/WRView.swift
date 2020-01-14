//
//  WRView.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/1/14.
//

import UIKit

@objc public protocol WRViewProtocol{
    var wr: WRViewExtension { get }
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
    
    /**拆切任意圆角*/
    /// - parameter corners: 圆角位置
    /// - parameter cornerRadius: 圆角半径
    @objc public func clipCorner(_ corners: UIRectCorner, cornerRadius: CGSize) {
        if let view = self.value as? UIView {
            let maskBezier = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), byRoundingCorners: corners, cornerRadii: cornerRadius)
            let maskLayer = CAShapeLayer.init()
            maskLayer.frame = CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            maskLayer.path = maskBezier.cgPath
            view.layer.mask = maskLayer
        }
    }

}
