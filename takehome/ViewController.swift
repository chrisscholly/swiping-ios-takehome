//
//  ViewController.swift
//  takehome
//
//  Created by Timothy Lenardo on 6/9/20.
//  Copyright © 2020 Takeoff Labs, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var collectionView: CardsCollectionView!
    @IBOutlet private weak var matchesCountLabel: UILabel!

    var profiles: [Profile] = []
    var matchesCount = 0 {
        didSet {
            updateMatchesCountLabel()
        }
    }

    @IBAction func didTapAcceptButton() {
        matchesCount += 1
        collectionView.goToNextCard()
    }

    @IBAction func didTapDeclineButton() {
        collectionView.goToPreviousCard()
    }
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMatchesCountLabel()
        setupCollectionView()
        loadProfiles()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: ProfileCell = collectionView.dequeueReusableCell(for: indexPath)
        let profile = profiles[indexPath.item]
        let viewModel = ProfileCell.ViewModel(profile: profile)
        cell.configure(with: viewModel)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return profiles.count
    }
}

private extension ViewController {
    func setupMatchesCountLabel() {
        updateMatchesCountLabel()
    }

    func setupCollectionView() {
        collectionView.cardSize = collectionView.bounds.size
        collectionView.dataSource = self
    }

    func loadProfiles() {
        ProfileService.getProfiles { result in
            switch result {
            case .success(let profiles):
                self.profiles = profiles.profiles
                self.collectionView.reloadData()
            case .failure(let error):
                // TODO: Handle error
                print("Error: \(error)")
            }
        }
    }

    func updateMatchesCountLabel() {
        matchesCountLabel.text = "\(matchesCount)"
    }
}
