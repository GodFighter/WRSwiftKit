//
//  WRScrollView.swift
//  Pods
//
//  Created by 项辉 on 2020/4/1.
//

import UIKit

extension UIScrollView {
    public override var wr: WRScrollViewExtension {
        return WRScrollViewExtension(self)
    }
}

//MARK:-  WRScrollViewExtension
@objc public class WRScrollViewExtension: WRViewExtension{
    internal init(_ value: UIScrollView){
        super.init(value)
        self.value = value
    }
    
    private var _scrollView: UIScrollView? {
        return self.value as? UIScrollView
    }
}

@objc public extension WRScrollViewExtension {
    
    var snapshot: UIImage? {
        guard let scrollView = _scrollView else { return nil }

        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = scrollView.frame
        scrollView.frame = CGRect(origin: scrollView.frame.origin, size: scrollView.contentSize)
        scrollView.layer.render(in: context)
        scrollView.frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }

}
