//
//  CropStyleCell.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/8/21.
//

import UIKit

final class CropStyleCell: UICollectionViewCell {

    // MARK: - @IBOutlets
    @IBOutlet private weak var coverImage: UIImageView!
    @IBOutlet private weak var nameStyle: UILabel!

    var viewModel: CropStyleViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        coverImage.layer.cornerRadius = coverImage.bounds.width / 2
        coverImage.clipsToBounds = true
    }

    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        coverImage.image = viewModel.cropStyleModel.coverImage
        nameStyle.text = viewModel.cropStyleModel.nameStyle
    }

}
