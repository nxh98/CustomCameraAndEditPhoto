//
//  CropBoxView.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/10/21.
//

import Foundation
import UIKit

class CropBoxView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        backgroundColor = .clear
        isUserInteractionEnabled = false
    }
}
