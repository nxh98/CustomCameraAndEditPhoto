//
//  CropPhotoCell.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/7/21.
//

import UIKit

final class PhotoEditorTypeCell: UICollectionViewCell {

    // MARK: - @IBOutlets
    @IBOutlet private var titleCell: UILabel!
    @IBOutlet private var backgroundImageView: UIImageView!

    // MARK: - Properties
    var viewModel: PhotoEditorTypeViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        titleCell.text = viewModel.titleCell
        backgroundImageView.image = viewModel.backgroundImage
    }
}
