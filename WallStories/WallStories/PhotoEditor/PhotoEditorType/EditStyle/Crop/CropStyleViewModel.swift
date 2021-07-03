//
//  CropStyleViewModel.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/8/21.
//

import Foundation
import UIKit

final class CropStyleViewModel {
    var cropStyleModel: CropStyleModel
    var isSelected: Bool = false

    init(cropStyleModel: CropStyleModel = CropStyleModel()) {
        self.cropStyleModel = cropStyleModel
    }
}
