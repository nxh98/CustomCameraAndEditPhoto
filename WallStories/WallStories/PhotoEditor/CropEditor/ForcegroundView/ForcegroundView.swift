//
//  ForcegroundView.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/9/21.
//

import Foundation
import UIKit

final class ForegroundView: UIView {
    public let imageView: UIImageView = UIImageView()
//    public var compareView: UIImageView
//    public var isEnabledTouches = true {
//        didSet {
//            isUserInteractionEnabled = isEnabledTouches
//        }
//    }

//    public var eclipsePreviewEnabled = false

//    override var frame: CGRect {
//        didSet {
//            imageView.frame = frame
//        }
//    }

    init(frame: CGRect, image: UIImage) {
//        compareView = UIImageView(frame: frame)
        super.init(frame: frame)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        layoutImageView()
        isUserInteractionEnabled = false

//        compareView.contentMode = .scaleAspectFit
//        addSubview(compareView)

//        clipsToBounds = true
//        layer.masksToBounds = true
    }

    func layoutImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true

    }

    internal func getViewableCompareView() -> UIImage {
//        compareView.frame = imageView.frame
//        compareView.isHidden = false
//        let image = UIImage(view: self)
        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
//        compareView.isHidden = true
        let newImage = UIImage(cgImage: (image?.cgImage)!)
        return newImage
    }

//    private func showCompareView() {
//        compareView.frame = imageView.frame
//        compareView.isHidden = false
//    }

//    private func hideCompareView() {
//        compareView.isHidden = true
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        showCompareView()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
//        hideCompareView()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
//        hideCompareView()
    }
}
