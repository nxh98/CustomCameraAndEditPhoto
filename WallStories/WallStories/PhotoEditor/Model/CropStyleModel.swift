//
//  CropStyleModel.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/8/21.
//

import Foundation
import UIKit

struct CropStyleModel {
    var coverImage: UIImage
    var nameStyle: String

    init(coverImage: UIImage = UIImage(named: "black") ?? UIImage(), nameStyle: String = "") {
        self.coverImage = coverImage
        self.nameStyle = nameStyle
    }
}
