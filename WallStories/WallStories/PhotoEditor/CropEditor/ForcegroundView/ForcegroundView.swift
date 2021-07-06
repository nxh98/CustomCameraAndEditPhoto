//
//  ForcegroundView.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/9/21.
//

import Foundation
import UIKit

final class ForegroundView: UIView {
    let imageView: UIImageView = UIImageView()

    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        layoutImageView()
        isUserInteractionEnabled = false
    }

    func layoutImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true

    }

    internal func getViewableCompareView() -> UIImage {
        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let newImage = UIImage(cgImage: (image?.cgImage)!)
        return newImage
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
