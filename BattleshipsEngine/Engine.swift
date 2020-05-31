//
//  Engine.swift
//  BattleshipsEngineTests
//
//  Created by Andrey Volobuev on 30/05/2020.
//  Copyright © 2020 Andrey Volobuev. All rights reserved.
//

import Foundation

final class Engine {
    private(set) var battleField: [[Place]] = [
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty]
        ]

    func fillPlace(at coordinate: Coordinate, with place: Place) {
        battleField[coordinate.vertical][coordinate.horizontal] = place
    }

    func freePlaces(from coordinate: Coordinate) -> DimensionalCount {

        let row = battleField[coordinate.vertical]

        guard case .empty = battleField[coordinate.vertical][coordinate.horizontal] else {
            return DimensionalCount.zero
        }

        let leftCount = Array(row[0...coordinate.horizontal]).reversedCountUntilOccupied

        let topCount = (0...coordinate.vertical).map {
            battleField[$0][coordinate.horizontal]
        }.reversedCountUntilOccupied

        let bottomCount = (coordinate.vertical..<battleField.count).map { battleField[$0][coordinate.horizontal]
        }.countUntilOccupied

        let rightCount = Array(row[coordinate.horizontal..<row.count]).countUntilOccupied

        return DimensionalCount(left: leftCount,
                                top: topCount,
                                right: rightCount,
                                bottom: bottomCount)
    }

    func place(_ ship: Ship, at coordinate: Coordinate, direction: Direction) {
        coordinate.shifting(by: ship.length, in: direction).forEach {
            battleField[$0.vertical][$0.horizontal] = .ship
        }
    }
}

extension Array where Element == Place {
    var countUntilOccupied: Int {
        firstIndex(where: \.isOccupied) ?? endIndex
    }

    var reversedCountUntilOccupied: Int {
        reversed().firstIndex(where: \.isOccupied) ?? endIndex
    }
}
