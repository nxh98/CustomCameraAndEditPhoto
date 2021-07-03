//
//  PhotoEditorViewController.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/7/21.
//

import UIKit

final class PhotoEditorViewController: UIViewController {

    // MARK: - @IBOutlet
    @IBOutlet private weak var bottomCollectionView: UICollectionView!
    @IBOutlet private weak var styleCollectionView: UICollectionView!
    @IBOutlet private weak var bodyView: UIView!

    // MARK: - Properties
    var viewModel = PhotoEditorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let cropView = CropView(frame: bodyView.bounds, image: UIImage(named: "largSize")!)
        bodyView.addSubview(cropView)
    }

    private func registerCell() {
        bottomCollectionView.dataSource = self
        bottomCollectionView.delegate = self
        bottomCollectionView.register(UINib(nibName: "PhotoEditorType", bundle: .main), forCellWithReuseIdentifier: "PhotoEditorType")
        styleCollectionView.dataSource = self
        styleCollectionView.delegate = self
        styleCollectionView.register(UINib(nibName: "CropStyleCell", bundle: .main), forCellWithReuseIdentifier: "CropStyleCell")
    }
}

// MARK: - extensions
extension PhotoEditorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return viewModel.numberCellOfBottom()
        case 1:
            return viewModel.numberStyle()
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoEditorType", for: indexPath) as? PhotoEditorTypeCell
            cell?.viewModel = viewModel.viewForCell(indexPath: indexPath)
            return cell ?? UICollectionViewCell()
        default:
            switch viewModel.type {
            case .crop:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CropStyleCell", for: indexPath) as? CropStyleCell
                cell?.viewModel = viewModel.cellForItemsCropStyle(indexPath: indexPath)
                return cell ?? UICollectionViewCell()
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CropStyleCell", for: indexPath) as? CropStyleCell
                cell?.viewModel = viewModel.cellForItemsFilterStyle(indexPath: indexPath)
                return cell ?? UICollectionViewCell()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            switch indexPath.item {
            case 0:
                if viewModel.type != .crop {
                    viewModel.type = .crop
                    styleCollectionView.reloadData()
                }
            case 1:
                if viewModel.type != .filter {
                    viewModel.type = .filter
                    styleCollectionView.reloadData()
                }
            default: break
            }
        default:
            break
        }
    }
}

extension PhotoEditorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: collectionView.bounds.width / 3, height: collectionView.bounds.height)
        default:
            return CGSize(width: 100, height: collectionView.bounds.height)
        }
    }
}
