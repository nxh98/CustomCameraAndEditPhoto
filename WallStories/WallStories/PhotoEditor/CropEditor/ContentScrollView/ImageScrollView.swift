//
//  ImageScrollView.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/10/21.
//

import Foundation
import UIKit

class ImageScrollView: UIScrollView {
    var imageView: UIImageView = UIImageView(image: UIImage())
    var touchesBegan: () -> Void = {}
    var touchesEnded: () -> Void = {}
    var touchesCancelled: () -> Void = {}

    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
//        self.delegate = self
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFit
        set(image: image)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchesBegan()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchesEnded()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchesCancelled()
    }

    func set(image: UIImage) {
        imageView.removeFromSuperview()
        imageView.image = nil
        imageView.image = image
        addSubview(imageView)
        config()
    }

    func config() {
        self.minimumZoomScale = 1
        self.maximumZoomScale = 4
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        self.contentSize = bounds.size
    }

    func getImageScaleSize() -> CGSize {
        guard let image = imageView.image else {
            return CGSize()
        }
        let scaleH = imageView.bounds.size.height / image.size.height
        let scaleW = imageView.bounds.size.width / image.size.width
        let aspect = min(scaleW, scaleH)
        let imageScaleSize = CGSize(width: image.size.width * aspect, height: image.size.height * aspect)
        return imageScaleSize
    }

    func getOriginImage() -> CGPoint {
        guard let image = imageView.image else {
            return CGPoint()
        }
        let originX = imageView.bounds.size.width - image.size.width
        let originY = imageView.bounds.size.height  - image.size.height
        return CGPoint(x: originX, y: originY)
    }
}
extension ImageScrollView {
    enum TouchesEvent {
        case touchesBegan
        case touchesEnded
        case touchesCanceled
    }
}
