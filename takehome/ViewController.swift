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

    var profiles: [Profile] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        loadProfiles()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.cardSize = collectionView.bounds.size
    }

    private func loadProfiles() {
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
    func setupCollectionView() {
        collectionView.dataSource = self
    }
}
