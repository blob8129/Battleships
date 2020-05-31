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

    var isOccupied: Bool {
        self != .empty
    }
}

struct DimensionalCount: Equatable {
    let left: Int
    let top: Int
    let right: Int
    let bottom: Int

    static var zero: DimensionalCount {
        DimensionalCount(left: 0, top: 0, right: 0, bottom: 0)
    }
}

struct Coordinate {
    let vertical: Int
    let horizontal: Int

    func shifting(by count: Int, in direction: Direction) -> [Coordinate] {
        switch direction {
        case .left:
            return (horizontal..<(horizontal + count))
                .map { Coordinate(vertical: vertical, horizontal: $0) }
        case .up:
            return (((vertical + 1) - count)...vertical)
                .map { Coordinate(vertical: $0, horizontal: horizontal) }
        case .right:
            return (((horizontal + 1) - count)...horizontal)
                .map { Coordinate(vertical: vertical, horizontal: $0) }
        case .down:
            return (vertical..<(vertical + count))
                .map { Coordinate(vertical: $0, horizontal: horizontal) }
        }
    }
}

struct Ship {
    let length: Int
}

enum Direction {
    case left, up, right, down
}
