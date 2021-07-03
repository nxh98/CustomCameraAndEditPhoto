//
//  UIImageExt.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/9/21.
//

import Foundation
import UIKit

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }

    func resize(toSizeInPixel: CGSize) -> UIImage {
        let screenScale = UIScreen.main.scale
        let sizeInPoint = CGSize(width: toSizeInPixel.width / screenScale,
                                 height: toSizeInPixel.height / screenScale)
        return resize(toSizeInPoint: sizeInPoint)
    }


    func resize(toSizeInPoint: CGSize) -> UIImage {
        let size = self.size
        var newImage: UIImage

        let widthRatio  = toSizeInPoint.width  / size.width
        let heightRatio = toSizeInPoint.height / size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        if #available(iOS 10.0, *) {
            let renderFormat = UIGraphicsImageRendererFormat.default()
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: newSize.width, height: newSize.height), format: renderFormat)
            newImage = renderer.image {
                (context) in
                self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
            self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }

        return newImage
    }
}
