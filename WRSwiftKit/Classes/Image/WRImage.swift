//
//  WRImage.swift
//  Pods
//
//  Created by 项辉 on 2020/1/14.
//

import UIKit

//MARK:-
@objc public protocol WRImageProtocol{
    var wr: WRImageExtension { get }
    
    static func size(_ size : CGSize, image : UIImage) -> UIImage?
    static func color(_ color : UIColor, size : CGSize) -> UIImage?
    static func color(colors : [UIColor], size : CGSize, locations: [CGFloat], start: CGPoint, end: CGPoint) -> UIImage?
    static func tintColor(_ tintColor: UIColor, image : UIImage) -> UIImage?
    static func cutting(image : UIImage, rect : CGRect) -> UIImage?
    static func snapshot(_ view : UIView, size : CGSize, scale : CGFloat, opaque: Bool) -> UIImage?
    static func combination(_ image : CGImage?, bgImage : CGImage?, size : CGSize, scale : CGFloat) -> UIImage?
    static func fixOrientation(_ fixImage : UIImage) -> UIImage
}

@objc extension UIImage: WRImageProtocol{
    
    /**图片扩展*/
    override public var wr: WRImageExtension {
        return WRImageExtension(self)
    }
        
    /**旋转*/
    @objc public static var Rotate: WRImageExtension.Rotate.Type {
        return WRImageExtension.Rotate.self
    }

    /**调整图片尺寸*/
    /**
    不修改比例
    */
    /// - parameter image: 需要修改的图片
    /// - parameter size: 修改的目标尺寸
    /// - returns: 新图片
    @objc public static func size(_ size: CGSize, image: UIImage) -> UIImage? {
        return WRImageExtension.size(image, size: size)
    }

    /**拆切指定尺寸的图片*/
    /**
    会改变图片的展示范围
    */
/// - parameter image: 需要修改的图片
    /// - parameter rect: 修改的目标frame
    /// - returns: 生成的图片
    @objc public static func cutting(image : UIImage, rect : CGRect) -> UIImage? {
        return WRImageExtension.cutting(image: image, rect)
    }

    /**构建指定尺寸、纯色图片*/
    /// - parameter color: 图片颜色
    /// - parameter size: 修改的目标尺寸
    /// - returns: 生成的图片
    @objc public static func color(_ color : UIColor, size : CGSize) -> UIImage? {
        return WRImageExtension.color(size, color)
    }

    /**构建指定尺寸、渐变色图片*/
    /// - parameter size: 修改的目标尺寸
    /// - parameter colors: 图片数组
    /// - parameter locations: 位置数组
    /// - parameter start: 开始点
    /// - parameter end: 结束点
    /// - returns: 生成的图片
    @objc public static func color(colors : [UIColor], size : CGSize, locations: [CGFloat], start: CGPoint, end: CGPoint) -> UIImage? {
        return WRImageExtension.color(size: size, colors: colors, locations: locations, start: start, end: end)
    }
    
    /**修改图片中不可见部分的颜色*/
    /// - parameter image: 待修改颜色图片
    /// - parameter tintColor: 目标颜色
    /// - returns: 生成的图片
    @objc public static func tintColor(_ tintColor: UIColor, image : UIImage) -> UIImage? {
        return WRImageExtension.tintColor(image, tintColor: tintColor)
    }

    /**快照View*/
    /// - parameter view: 拍照对象
    /// - parameter size: 目标尺寸
    /// - parameter scale: 放大倍数
    /// - parameter opaque: 不透明
    /// - returns: 生成的图片
    @objc public static func snapshot(_ view : UIView, size : CGSize, scale : CGFloat, opaque: Bool) -> UIImage? {
        return WRImageExtension.snapshot(view, size: size, scale: scale, opaque: opaque)
    }
    
    /**图片合并*/
    /// - parameter image: 合成图片
    /// - parameter bgImage: 合成图片-底部
    /// - parameter scale: 放大倍数
    /// - parameter size: 尺寸
    /// - returns: 生成的图片
    @objc public static func combination(_ image : CGImage?, bgImage : CGImage?, size : CGSize, scale : CGFloat) -> UIImage? {
        return WRImageExtension.combination(image, bgImage: bgImage, size: size, scale: scale)
    }
    
    /**修正图片方向*/
    /// - parameter fixImage: 合成图片
    /// - returns: 修正后的图片
   @objc public static func fixOrientation(_ fixImage : UIImage) -> UIImage {
        return WRImageExtension.fixOrientation(fixImage)
    }
}

//MARK:-
@objc public class WRImageExtension: WRObjectExtension{
    init(_ value: UIImage){
        super.init(value)
        self.value = value
    }
    
    //MARK:图片旋转
    @objc public class Rotate : NSObject {
                
        /**旋转图片*/
        /// - parameter image: 需要修改的图片
        /// - parameter angle: 角度
        /// - returns: 新图片
        @objc public static func angle(_ image : UIImage, _ angle : CGFloat) -> UIImage?{
            guard let cgImage = image.cgImage, angle.truncatingRemainder(dividingBy: 360) != 0 else{
                return image
            }
            
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale);
            
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            
            let radian = CGFloat(angle / 180.0 * CGFloat.pi)
            
            var transform = CGAffineTransform.identity
            
            transform = transform.translatedBy(x: 0, y: 0)
            transform = transform.translatedBy(x: image.size.width / 2.0, y: image.size.height / 2.0)
            transform = transform.rotated(by: radian)
            transform = transform.translatedBy(x: -image.size.width / 2.0, y: -image.size.height / 2.0)
            
            context.concatenate(transform)
            
            context.translateBy(x: 0, y: image.size.height);
            context.scaleBy(x: 1.0, y: -1.0);
            
            context.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: image.size))
            
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage
        }
        
        /**垂直旋转图片*/
        /// - parameter image: 需要修改的图片
        /// - returns: 新图片
        @objc public static func vertical(_ image : UIImage ) -> UIImage?{
            
            guard let cgImage = image.cgImage else{
                return image
            }
            
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale);
            
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            
            context.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: image.size))
            
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage
        }
        
        /**水平旋转图片*/
        /// - parameter image: 需要修改的图片
        /// - returns: 新图片
        @objc public static func horizontal(_ image : UIImage ) -> UIImage?{
            
            guard let cgImage = image.cgImage else{
                return image
            }
            
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale);
            
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            
            context.translateBy(x: image.size.width, y: image.size.height)
            context.rotate(by: CGFloat(Double.pi))
            
            context.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: image.size))
            
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage
        }
    }

    fileprivate static func size(_ image : UIImage, size : CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
        
        guard let _ = UIGraphicsGetCurrentContext() else{
            return nil
        }
        
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let updateImage : UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return updateImage
    }

    fileprivate static func cutting(image : UIImage, _ rect : CGRect) -> UIImage?{
        
        let scale = image.scale
        let imageSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let cuttingRect = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.width * scale, height: rect.height * scale)
        
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        
        guard let context = UIGraphicsGetCurrentContext(), let cgImage = image.cgImage?.cropping(to: cuttingRect) else{
            return nil
        }
        
        WRContext.draw(context, image: cgImage, rect: cuttingRect)
        
        let cuttingImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext()
        
        return cuttingImage
    }

    fileprivate static func color(_ size : CGSize, _ color : UIColor) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else{
            return nil
        }
        
        color.setFill()
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

    fileprivate static func color(size : CGSize, colors : [UIColor], locations: [CGFloat] = [0.0, 1.0], start: CGPoint, end: CGPoint) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else{
            return nil
        }
        
        //使用rgb颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        //颜色数组（这里使用三组颜色作为渐变）fc6820
        var compoents:[CGFloat] = []
        
        for color in colors{
            
            var red : CGFloat = 0
            var blue : CGFloat = 0
            var green : CGFloat = 0
            var alpha : CGFloat = 0
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            compoents.append(red)
            compoents.append(green)
            compoents.append(blue)
            compoents.append(alpha)
        }
        
        //没组颜色所在位置（范围0~1)
        let locations:[CGFloat] = locations
        //生成渐变色（count参数表示渐变个数）
        let gradient = CGGradient(colorSpace: colorSpace,
                                  colorComponents: compoents,
                                  locations: locations,
                                  count: locations.count)!
        
        
        let start = CGPoint(x: start.x * size.width, y: start.y * size.height)
        
        let end = CGPoint(x: end.x * size.width, y: end.y * size.height)
        
        
        //绘制渐变
        context.drawLinearGradient(gradient,
                                   start: start,
                                   end: end,
                                   options: .drawsBeforeStartLocation)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

    fileprivate static func tintColor(_ image : UIImage, tintColor: UIColor) -> UIImage? {

        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height) as CGRect
        if let cgImage = image.cgImage {
            context?.clip(to: rect, mask:  cgImage)
        }
        
        tintColor.setFill()
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    fileprivate static func snapshot(_ view : UIView, size : CGSize, scale : CGFloat, opaque: Bool) -> UIImage?{
        
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        
        guard let context = UIGraphicsGetCurrentContext() else{
            return nil
        }
        
        context.saveGState()
        
        context.scaleBy(x: size.width / view.bounds.size.width, y: size.height / view.bounds.size.height)
        view.layer.render(in: context)
        
        context.restoreGState()
        
        let snapshotImage : UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return snapshotImage
    }

    fileprivate static func combination(_ image : CGImage?, bgImage : CGImage?, size : CGSize, scale : CGFloat) -> UIImage?{
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale);
        
        guard let context = UIGraphicsGetCurrentContext() else{
            return nil
        }
        
        WRContext.draw(context, image: bgImage, rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        WRContext.draw(context, image: image, rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return resultingImage
    }

    fileprivate static func fixOrientation(_ fixImage : UIImage) -> UIImage{
        
        guard let fixImageCG = fixImage.cgImage , fixImage.imageOrientation != UIImage.Orientation.up else{
            return fixImage
        }
        
        var transform = CGAffineTransform.identity
        
        switch fixImage.imageOrientation{
        case .down, .downMirrored:
            
            transform = transform.translatedBy(x: fixImage.size.width, y: fixImage.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .left,.leftMirrored:
            transform = transform.translatedBy(x: fixImage.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case .right,.rightMirrored:
            transform = transform.translatedBy(x: 0, y: fixImage.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi / 2))
        default: break;
        }
        
        switch fixImage.imageOrientation{
        case .upMirrored,.downMirrored:
            transform = transform.translatedBy(x: fixImage.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored,.rightMirrored:
            transform = transform.translatedBy(x: fixImage.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default: break;
        }
        
        let context : CGContext = CGContext(data: nil, width: Int(fixImage.size.width), height: Int(fixImage.size.height),
                                            bitsPerComponent: fixImageCG.bitsPerComponent, bytesPerRow: 0, space: fixImageCG.colorSpace!, bitmapInfo: 1)!
        
        context.concatenate(transform)
        switch fixImage.imageOrientation{
        case .left, .leftMirrored, .right, .rightMirrored:
            context.draw(fixImageCG, in: CGRect(x: 0, y: 0, width: fixImage.size.height, height: fixImage.size.width))
        default:
            context.draw(fixImageCG, in: CGRect(x: 0, y: 0, width: fixImage.size.width, height: fixImage.size.height))
        }
        
        guard let imageCG : CGImage = context.makeImage() else{
            return fixImage
        }
        
        return  UIImage(cgImage: imageCG)
    }


}

fileprivate struct WRContext{
    
    fileprivate static func clear(_ context : CGContext, rect : CGRect){
        
        context.saveGState();
        
        context.addRect(rect)
        context.setBlendMode(.clear)
        context.drawPath(using: .fill)
        
        context.restoreGState();
    }
    
    fileprivate static func draw(_ context : CGContext, image : CGImage?, rect : CGRect){
        
        guard let image = image else{
            return
        }
        
        context.saveGState();
        
        context.translateBy(x: rect.origin.x, y: rect.origin.y);
        context.translateBy(x: 0, y: rect.size.height);
        context.scaleBy(x: 1.0, y: -1.0);
        context.translateBy(x: -rect.origin.x, y: -rect.origin.y);
        
        context.draw(image, in: rect)
        
        context.restoreGState();
    }

}
