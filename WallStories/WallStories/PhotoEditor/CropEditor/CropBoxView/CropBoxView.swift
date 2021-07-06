//
//  CropBoxView.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/10/21.
//

import Foundation
import UIKit

class CropBoxView: UIView {

    var imageView: UIImageView = UIImageView()

    override var frame: CGRect {
        didSet {
            imageView.bounds = bounds
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configImageView()
        setup()
    }

    convenience init(frame: CGRect, image: UIImage) {
        self.init(frame: frame)
        imageView.image = image
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configImageView() {
        imageView.bounds = bounds
        addSubview(imageView)
    }

    private func setup() {
        backgroundColor = .clear
        isUserInteractionEnabled = false
        clipsToBounds = true
        layer.masksToBounds = true
    }
}
