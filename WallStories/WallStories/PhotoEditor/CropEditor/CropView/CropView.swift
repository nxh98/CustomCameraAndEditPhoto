//
//  CropView.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/9/21.
//

import Foundation
import UIKit

class CropView : UIView {
    public var scrollView: ImageScrollView
    private let cropBoxView: CropBoxView
    public let forcegroundView: ForegroundView
    private let translucencyView: TranslucencyView

    init(frame: CGRect, image: UIImage) {
        translucencyView = TranslucencyView(effect: UIBlurEffect(style: .extraLight))
        scrollView = ImageScrollView(frame: frame, image: image)
        forcegroundView = ForegroundView(frame: CGRect(), image: image)
        cropBoxView = CropBoxView(frame: CGRect())
        super.init(frame: frame)
        scrollView.delegate = self
        addSubview(scrollView)
        layoutScrollView()
        addSubview(translucencyView)
        addSubview(forcegroundView)
        handleScrollViewTouches()
        layoutTranslucencyView()
        self.backgroundColor = .white
        getFrameForForceground()
        addSubview(cropBoxView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func handleScrollViewTouches() {
        scrollView.touchesBegan = { [weak self] in
            self?.translucencyView.safetyHide()
        }

        scrollView.touchesEnded = { [weak self] in
            self?.translucencyView.scheduleShowing()
        }

        scrollView.touchesCancelled = { [weak self] in
            self?.translucencyView.scheduleShowing()
        }
    }

    private func layoutTranslucencyView() {
        translucencyView.translatesAutoresizingMaskIntoConstraints = false
        translucencyView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        translucencyView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        translucencyView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        translucencyView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        translucencyView.isUserInteractionEnabled = false
    }

    private func layoutScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }

    private func getFrameForForceground() {
        let size = scrollView.getImageScaleSize()
        forcegroundView.center = self.center
        forcegroundView.bounds.size = size
        cropBoxView.frame = forcegroundView.frame
    }

    private func matchForegroundToBackground() {
        forcegroundView.imageView.frame = scrollView.convert(scrollView.imageView.frame, to: forcegroundView)
    }

    @objc private func testMove() {
        translucencyView.isHidden = !translucencyView.isHidden
    }

//    public func getCroppedThumbImage() -> UIImage {
//        return forcegroundView.getViewableCompareView().resize(toSizeInPixel: CGSize(width: 90, height: 90))
//    }
}
extension CropView: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        matchForegroundToBackground()
        translucencyView.safetyHide()
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        matchForegroundToBackground()
        translucencyView.safetyHide()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        translucencyView.scheduleShowing()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            translucencyView.scheduleShowing()
        }
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        forcegroundView.isHidden = false
        matchForegroundToBackground()
        translucencyView.scheduleShowing()
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        forcegroundView.isHidden = true
        return self.scrollView.imageView
    }
}
