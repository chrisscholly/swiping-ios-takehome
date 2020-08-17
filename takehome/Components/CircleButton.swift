//
//  CircleButton.swift
//  takehome
//
//  Created by Christophe Scholly on 17/08/2020.
//  Copyright © 2020 Takeoff Labs, Inc. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
}
