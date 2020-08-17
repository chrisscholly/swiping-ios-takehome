//
//  CardsCollectionViewLayout.swift
//  takehome
//
//  Created by Christophe Scholly on 17/08/2020.
//  Copyright © 2020 Takeoff Labs, Inc. All rights reserved.
//

import UIKit

class CardsCollectionViewLayout: UICollectionViewLayout {

    var itemSize: CGSize = CGSize(width: 100, height: 100) {
        didSet {
            invalidateLayout()
        }
    }

    var maximumVisibleItems: Int = 3 {
        didSet {
            invalidateLayout()
        }
    }

    private var spacing: CGPoint {
        return CGPoint(x: 0, y: itemSize.height * 0.09)
    }

    override var collectionView: UICollectionView {
        return super.collectionView!
    }

    override var collectionViewContentSize: CGSize {
        let itemsCount = CGFloat(collectionView.numberOfItems(inSection: 0))
        return CGSize(width: collectionView.bounds.width,
                      height: collectionView.bounds.height * itemsCount)
    }

    override func prepare() {
        super.prepare()
        assert(collectionView.numberOfSections == 1, "Multiple sections aren't supported!")
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let totalItemsCount = collectionView.numberOfItems(inSection: 0)
        let minVisibleIndex = max(Int(collectionView.contentOffset.y) / Int(collectionView.bounds.height), 0)
        let maxVisibleIndex = min(minVisibleIndex + maximumVisibleItems, totalItemsCount)
        let visibleIndices = minVisibleIndex..<maxVisibleIndex
        let attributes: [UICollectionViewLayoutAttributes?] = visibleIndices.map { index in
            let indexPath = IndexPath(item: index, section: 0)
            return self.layoutAttributesForItem(at: indexPath)
        }
        let filteredAttributes = attributes.compactMap { $0 }
        return filteredAttributes
    }

    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let minVisibleIndex = Int(collectionView.contentOffset.y) / Int(collectionView.bounds.height)
        let deltaOffset = CGFloat(Int(collectionView.contentOffset.y) % Int(collectionView.bounds.height))
        let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView.bounds.height
        let visibleIndex = indexPath.row - minVisibleIndex

        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.size = itemSize
        let midY = self.collectionView.bounds.midY
        let midX = self.collectionView.bounds.midX
        attributes.center = CGPoint(x: midX + spacing.x * CGFloat(visibleIndex),
                                    y: midY + spacing.y * CGFloat(visibleIndex))
        attributes.zIndex = maximumVisibleItems - visibleIndex
        attributes.transform = scaleTransform(forVisibleIndex: visibleIndex,
                                              percentageOffset: percentageDeltaOffset)

        switch visibleIndex {
        case 0:
            attributes.center.y -= deltaOffset
            attributes.isHidden = false
            attributes.alpha = abs(1 - percentageDeltaOffset)
        case 1..<maximumVisibleItems:
            attributes.center.x -= spacing.x * percentageDeltaOffset
            attributes.center.y -= spacing.y * percentageDeltaOffset
            if visibleIndex == maximumVisibleItems - 1 {
                attributes.alpha = percentageDeltaOffset
            } else {
                attributes.alpha = 1.0
            }
            attributes.isHidden = false
        default:
            attributes.alpha = 0
            attributes.isHidden = true
        }
        return attributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

private extension CardsCollectionViewLayout {
    func scale(at index: Int) -> CGFloat {
        guard index > 0 else {
            return 1
        }
        let translatedCoefficient = CGFloat(index + 1) - CGFloat(self.maximumVisibleItems - 1) / 2
        return CGFloat(pow(0.9, translatedCoefficient))
    }

    func scaleTransform(forVisibleIndex visibleIndex: Int, percentageOffset: CGFloat) -> CGAffineTransform {
        guard visibleIndex < maximumVisibleItems else {
            return CGAffineTransform.identity
        }
        var rawScale = scale(at: visibleIndex)
        let previousScale = scale(at: visibleIndex - 1)
        let delta = (previousScale - rawScale) * percentageOffset
        rawScale += delta
        return CGAffineTransform(scaleX: rawScale, y: rawScale)
    }
}
