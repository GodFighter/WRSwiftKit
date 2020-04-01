//
//  WRTextField.swift
//  Pods
//
//  Created by 项辉 on 2020/4/1.
//

import UIKit


extension UITextField {
    public override var wr: WRTextFieldExtension {
        return WRTextFieldExtension(self)
    }
}

//MARK:-  WRTextFieldExtension
@objc public class WRTextFieldExtension: WRViewExtension{
    internal init(_ value: UITextField){
        super.init(value)
        self.value = value
    }
    
    private var _textField: UITextField? {
        return self.value as? UITextField
    }
}

@objc public extension WRTextFieldExtension {
    @objc func setPlaceHolderTextColor(_ color: UIColor) {
        guard let textField = _textField else { return }
        guard let holder = textField.placeholder, !holder.isEmpty else { return }
        textField.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }
    
    @objc func addPaddingLeft(_ padding: CGFloat) {
        guard let textField = _textField else { return }
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }

    @objc func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        guard let textField = _textField else { return }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        textField.leftView = imageView
        textField.leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        textField.leftViewMode = .always
    }

}
