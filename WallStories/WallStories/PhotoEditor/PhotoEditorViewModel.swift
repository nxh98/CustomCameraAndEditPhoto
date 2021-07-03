//
//  PhotoEditorViewModel.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/7/21.
//

import Foundation
import UIKit

final class PhotoEditorViewModel {

    // MARK: - Properties
    var photo: UIImage
    var editTypes: [PhotoEditorTypeViewModel] = [PhotoEditorTypeViewModel(titleCell: "Crop"), PhotoEditorTypeViewModel(titleCell: "XXX"), PhotoEditorTypeViewModel(titleCell: "YYY"), PhotoEditorTypeViewModel(titleCell: "ZZZ")]
    private let cropStyles: [CropStyleModel] = [CropStyleModel(nameStyle: "Style 1"), CropStyleModel(nameStyle: "Style 2"), CropStyleModel(nameStyle: "Style 3"), CropStyleModel(nameStyle: "Style 4")]

    // dummy
    private let filterStyles: [CropStyleModel] = [CropStyleModel(nameStyle: "Filter 1"), CropStyleModel(nameStyle: "Filter 2"), CropStyleModel(nameStyle: "Filter 3")]

    var type = EditType.crop

    // MARK: - Init
    init(image: UIImage = UIImage()) {
        photo = image
    }

    func setSelectedTypeIndex() -> Int {
        switch type {
        case .crop:
            return 0
        case .filter:
            return 1
        }
    }

    // Type Edit
    func numberCellOfBottom() -> Int {
        return editTypes.count
    }

    func viewForCell(indexPath: IndexPath) -> PhotoEditorTypeViewModel {
        return editTypes[indexPath.item]
    }

    func numberStyle() -> Int {
        switch type {
        case .crop:
            return cropStyles.count
        default:
            return filterStyles.count
        }
    }

    func cellForItemsCropStyle(indexPath: IndexPath) -> CropStyleViewModel {
        return CropStyleViewModel(cropStyleModel: cropStyles[indexPath.item])
    }

    func cellForItemsFilterStyle(indexPath: IndexPath) -> CropStyleViewModel {
        return CropStyleViewModel(cropStyleModel: filterStyles[indexPath.item])
    }
}
extension PhotoEditorViewModel {
    enum EditType {
        case crop
        case filter
    }
}
