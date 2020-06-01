//
//  Place.swift
//  BattleshipsEngine
//
//  Created by Andrey Volobuev on 31/05/2020.
//  Copyright © 2020 Andrey Volobuev. All rights reserved.
//

import Foundation

public enum Place: Equatable {
    case empty
    case ship
    case hit
    case miss

    var isOccupied: Bool {
        self != .empty
    }

    var receivingHit: Place {
        switch self {
        case .empty:
            return .miss
        case .ship:
            return .hit
        default:
            return self
        }
    }
}

public struct DimensionalCount: Equatable {
    let left: Int
    let up: Int
    let right: Int
    let down: Int

    static var zero: DimensionalCount {
        DimensionalCount(left: 0, up: 0, right: 0, down: 0)
    }
}

public struct Coordinate {
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

public struct Ship: Equatable {
    let length: Int

    public init(length: Int) {
        self.length = length
    }
}

public enum Direction {
    case left, up, right, down
}

public extension Array where Element == [Place] {

    subscript(_ coordinate: Coordinate) -> Place {
        get {
            self[coordinate.vertical][coordinate.horizontal]
        } set(newValue) {
            self[coordinate.vertical][coordinate.horizontal] = newValue
        }
    }

    subscript(_ vertical: Int, _ horizontal: Int) -> Place {
        get {
            self[vertical][horizontal]
        } set(newValue) {
            self[vertical][horizontal] = newValue
        }
    }
}
