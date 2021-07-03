//
//  TranflucencyView.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/9/21.
//

import Foundation
import UIKit

enum CropTranslucencyStatus {
    case show
    case hide
    case beingShow
    case beingHide
    case scheduledShow
}

class TranslucencyView: UIVisualEffectView {
    private let showAlpha: CGFloat = 1.0
    private let hideAlpha: CGFloat = 0.5

    public var status: CropTranslucencyStatus = .show

    private var timer: Timer?

    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        timer?.invalidate()
        timer = nil
    }

    public func scheduleShowing() {
        if status == .show || status == .beingShow {
            return
        }

        if status == .scheduledShow {
            timer?.invalidate()
            timer = nil
        }

        layer.removeAllAnimations()
        status = .scheduledShow
        timer = Timer.scheduledTimer(timeInterval: 0.2,
                                     target: self,
                                     selector: #selector(show),
                                     userInfo: nil,
                                     repeats: false)
    }

    // MARK: - show/hide translucent view
    @objc private func show() {
        status = .beingShow
        UIView.animate(withDuration: 0.2,
                       animations: {
                        self.alpha = self.showAlpha
        },
                       completion: { _ in
                        self.status = .show
        })
    }

    private func hide() {
        status = .beingHide
        layer.removeAllAnimations()
        UIView.animate(withDuration: 0.2,
                       animations: {
                        self.alpha = self.hideAlpha
        },
                       completion: { _ in
                        self.status = .hide
        })
    }

    public func safetyHide() {
        if status != .beingHide && status != .hide {
            timer?.invalidate()
            hide()
        }
    }

    public func safetyShow() {
        if status == .scheduledShow {
            timer?.invalidate()
            timer = nil
        }
        if status != .show && status != .beingShow {
            show()
        }
    }
}

