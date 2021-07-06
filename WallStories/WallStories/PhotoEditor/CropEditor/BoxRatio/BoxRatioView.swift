//
//  BoxRatio.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 06/07/2021.
//

import Foundation
import UIKit

final class BoxRatioView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configUI() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.red.cgColor
        backgroundColor = .clear
        isUserInteractionEnabled = false
        clipsToBounds = true
        layer.masksToBounds = true
    }
}
