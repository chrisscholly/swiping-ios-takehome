//
//  Reusable.swift
//  takehome
//
//  Created by Christophe Scholly on 17/08/2020.
//  Copyright © 2020 Takeoff Labs, Inc. All rights reserved.
//

import Foundation

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
