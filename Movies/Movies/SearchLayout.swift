//
//  SearchLayout.swift
//  Movies
//
//  Created by Forrest Zhao on 1/15/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit

protocol SearchLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath,
                        withWidth:CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat
}

class SearchLayout: UICollectionViewLayout {
    var delegate: SearchLayoutDelegate!
    var numberOfColumns = 2
    var cellPadding: CGFloat = 6.0
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return (collectionView?.bounds)!.width - (insets.left + insets.right)
    }
}
