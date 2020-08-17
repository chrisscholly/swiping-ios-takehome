//
//  NibReusable.swift
//  takehome
//
//  Created by Christophe Scholly on 17/08/2020.
//  Copyright © 2020 Takeoff Labs, Inc. All rights reserved.
//

import UIKit

protocol NibReusable: Reusable {
    static var nib: UINib { get }
}

extension NibReusable {
    static var nib: UINib {
        let nibName = String(describing: self)
        return UINib(nibName: nibName, bundle: .main)
    }
}
