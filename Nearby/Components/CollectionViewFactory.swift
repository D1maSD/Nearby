//
//  CollectionViewFactory.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 03.01.2024.
//

import UIKit

struct CollectionViewFactory {
    static func make() -> UICollectionView {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }

    static func make(layout: UICollectionViewLayout) -> UICollectionView {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }
}
