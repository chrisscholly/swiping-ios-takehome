//
//  CardsCollectionView.swift
//  takehome
//
//  Created by Christophe Scholly on 17/08/2020.
//  Copyright © 2020 Takeoff Labs, Inc. All rights reserved.
//

import UIKit

class CardsCollectionView: UICollectionView {

    var cardSize: CGSize = .zero {
        didSet {
            cardsLayout.itemSize = cardSize
        }
    }
    var cardIndexChanged: ((Int) -> Void)?

    private let cardsLayout = CardsCollectionViewLayout()
    private var currentCardIndex = 0 {
        didSet {
            cardIndexChanged?(currentCardIndex)
        }
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    func goToNextCard() {
        goToCard(index: currentCardIndex + 1)
    }

    func goToPreviousCard() {
        goToCard(index: currentCardIndex - 1)
    }

    private func commonInit() {
        collectionViewLayout = cardsLayout
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        clipsToBounds = false
        delegate = self
    }

    private func goToCard(index: Int) {
        let itemsCount = numberOfItems(inSection: 0)
        guard index >= 0 && index <= itemsCount - 1 else { return }
        let contentOffsetY = CGFloat(index) * bounds.height
        setContentOffset(CGPoint(x: 0, y: contentOffsetY), animated: true)
        currentCardIndex = index
    }

    fileprivate func scrollViewDidEnd() {
        let currentCardIndex = contentOffset.y / bounds.height
        self.currentCardIndex = Int(currentCardIndex)
    }
}

extension CardsCollectionView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEnd()
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEnd()
    }
}
