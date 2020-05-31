//
//  Engine.swift
//  BattleshipsEngineTests
//
//  Created by Andrey Volobuev on 30/05/2020.
//  Copyright © 2020 Andrey Volobuev. All rights reserved.
//

import Foundation

final class Engine {
    var battleField: [[Place]] = [
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


    func freePlaces(from coordinate: Coordinate) -> DimensionalCount {
        
        let row = battleField[coordinate.vertical]

        let leftCount = row[0...coordinate.horizontal].count

        let topCount = (0...coordinate.vertical).map {
            battleField[$0][coordinate.horizontal]
        }.count

        let bottomCount = (coordinate.vertical..<battleField.count).map { battleField[$0][coordinate.horizontal]
        }.count

        let rightCount = row[coordinate.horizontal..<row.count].count

        return DimensionalCount(left: leftCount,
                                top: topCount,
                                right: rightCount,
                                bottom: bottomCount)
    }
}

