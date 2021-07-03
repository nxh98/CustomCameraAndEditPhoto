//
//  CropPhotoViewModel.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/7/21.
//

import Foundation
import UIKit

final class PhotoEditorTypeViewModel {
    let titleCell: String
    let backgroundImage: UIImage

    init(titleCell: String, backgroundImage: UIImage = UIImage()) {
        self.titleCell = titleCell
        self.backgroundImage = backgroundImage
    }


}
