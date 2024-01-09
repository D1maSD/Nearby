//
//  Colors.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 04.10.2022.
//

import UIKit

@objc public extension UIColor {

  static let pointColor = UIColor.color(named: "pointColor")
  static let pointSelectedColor = UIColor.color(named: "pointSelectedColor")
  static let blurColor = UIColor.color(named: "blurColor")
  static let buttonTextColor = UIColor.color(named: "buttonTextColor")
  static let darkRoundedButtonColor = UIColor.color(named: "darkRoundedButtonColor")
  static let defaultBackgroundColor = UIColor.color(named: "defaultBackgroundColor")
  static let defaultBlackColor = UIColor.color(named: "defaultBlackColor")
  static let defaultGrayTextFieldColor = UIColor.color(named: "defaultGrayTextFieldColor")
  static let outlineButtonColor = UIColor.color(named: "outlineButtonColor")
  static let subtitleTextColor = UIColor.color(named: "subtitleTextColor")
  static let titleTextColor = UIColor.color(named: "titleTextColor")
  static let allColors: [UIColor] = [
    pointColor,
    pointSelectedColor,
    blurColor,
    buttonTextColor,
    darkRoundedButtonColor,
    defaultBackgroundColor,
    defaultBlackColor,
    defaultGrayTextFieldColor,
    outlineButtonColor,
    subtitleTextColor,
    titleTextColor,
  ]

  static let allNames: [String] = [
    "pointColor",
    "pointSelectedColor",
    "blurColor",
    "buttonTextColor",
    "darkRoundedButtonColor",
    "defaultBackgroundColor",
    "defaultBlackColor",
    "defaultGrayTextFieldColor",
    "outlineButtonColor",
    "subtitleTextColor",
    "titleTextColor",
  ]

  private static func color(named: String) -> UIColor {
      return UIColor(named: named) ?? UIColor.white
  }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            self.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

