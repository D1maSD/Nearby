//
//  UITableView+Reusable.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 03.01.2024.
//

import UIKit

extension UITableView {

    func register<T: Reusable>(cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: cellType.identifier)
    }

    func register<T: Reusable>(cellType: T.Type, bundle: Bundle?) {
        let nib = UINib(nibName: cellType.identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: cellType.identifier)
    }

    func registerFromNib(cell: UITableViewCell.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.nibName)
    }

    func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.identifier) matching type \(cellType.self).")
        }
        return cell
    }

    func register<T: Reusable>(viewType: T.Type) {
        register(viewType.self, forHeaderFooterViewReuseIdentifier: viewType.identifier)
    }

    func dequeueReusableHeaderFooterView<T: Reusable>() -> T {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(T.identifier) matching type \(T.self).")
        }
        return headerFooter
    }
}

extension UITableViewCell: Reusable {
    open class var nib: UINib {
        return UINib(nibName: self.nibName, bundle: nil)
    }
}

extension UICollectionReusableView: Reusable { }

extension UITableViewHeaderFooterView: Reusable { }

protocol Reusable: AnyObject {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.identifier) matching type \(cellType.self).")
        }
        return cell
    }

    func register<T: Reusable>(cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }

    func registerView<T: Reusable>(viewType: T.Type, forSupplementaryViewOfKind: String) {
        register(viewType, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: viewType.identifier)
    }

    func dequeueReusableView<T: Reusable>(ofKind: String, indexPath: IndexPath, viewType: T.Type = T.self) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: viewType.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(viewType.identifier) matching type \(viewType.self).")
        }
        return view
    }
}

extension UICollectionViewCell: Reusable {
    open class var nib: UINib {
        return UINib(nibName: self.nibName, bundle: nil)
    }
}



extension UIView {

    class var nibName: String {
        return String(describing: self)
    }

    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self),
                                        owner: nil,
                                        options: nil)?
            .first as! T // swiftlint:disable:this force_cast
    }

    func connectNibUI() -> Any? {
        let nibView = Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                               owner: nil,
                                               options: nil)?
            .first as! UIView // swiftlint:disable:this force_cast
        nibView.frame = frame
        self.addSubview(nibView)
        return nibView
    }
}
