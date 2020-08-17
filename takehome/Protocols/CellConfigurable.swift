//
//  CellConfigurable.swift
//  takehome
//
//  Created by Christophe Scholly on 17/08/2020.
//  Copyright © 2020 Takeoff Labs, Inc. All rights reserved.
//

import Foundation

protocol CellConfigurable {
    associatedtype T
    var viewModel: T! { get set }
    func configure(with viewModel: T)
}
