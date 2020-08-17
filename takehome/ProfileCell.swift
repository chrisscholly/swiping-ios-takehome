//
//  ProfileCell.swift
//  takehome
//
//  Created by Christophe Scholly on 17/08/2020.
//  Copyright © 2020 Takeoff Labs, Inc. All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    var viewModel: ViewModel!

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var profileTitle: UILabel!
    @IBOutlet private weak var profileSubtitle: UILabel!
}

extension ProfileCell: CellConfigurable {
    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel

        profileImageView.load(url: viewModel.profileImageViewURL)
        profileTitle.text = viewModel.profileTitleText
        profileSubtitle.text = viewModel.profileSubtitleText
    }
}

extension ProfileCell: Reusable {}

extension ProfileCell {
    struct ViewModel {
        let profile: Profile
    }
}

extension ProfileCell.ViewModel {
    var profileImageViewURL: URL? { profile.photos.first }
    var profileTitleText: String { profile.firstName }
    var profileSubtitleText: String { profile.address }
}
