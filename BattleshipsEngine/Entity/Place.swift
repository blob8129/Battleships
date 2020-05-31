//
//  Place.swift
//  BattleshipsEngine
//
//  Created by Andrey Volobuev on 31/05/2020.
//  Copyright © 2020 Andrey Volobuev. All rights reserved.
//

import Foundation

enum Place: Equatable {
    case empty
    case ship
    case hit
    case miss
}

struct DimensionalCount: Equatable {
    let left: Int
    let top: Int
    let right: Int
    let bottom: Int
}

struct Coordinate {
    let vertical: Int
    let horizontal: Int
}
