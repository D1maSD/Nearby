//
//  TextField.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 28.11.2022.
//

import UIKit

class TextField: UITextField {
  
  let padding = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 5)
  
  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
}
