//
//  UIView+extensions.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 01.01.2024.
//

import UIKit


extension UIView {
    func theRightDistanceFromTheTop() -> CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let isIPhoneWithBangs: Bool = { return UIScreen.main.bounds.height >= 812 }()
        let heightStatusBar = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let iphoneMiniSize = CGRect(x: 0, y: 0, width: 375, height: 812)

        if isIPhoneWithBangs && iphoneMiniSize != UIScreen.main.bounds && iphoneMiniSize != UIScreen.main.bounds {
            return heightStatusBar / 1.068
        } else if !isIPhoneWithBangs && iphoneMiniSize == UIScreen.main.bounds {
            return heightStatusBar / 1.136
        } else {
            return heightStatusBar
        }
    }

    func removeAllSubviews() {
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
