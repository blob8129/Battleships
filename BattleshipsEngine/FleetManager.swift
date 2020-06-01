//
//  FleetManager.swift
//  BattleshipsEngine
//
//  Created by Andrey Volobuev on 01/06/2020.
//  Copyright © 2020 Andrey Volobuev. All rights reserved.
//

import Foundation

final class FleetManager {

    var ships: [Ship]

    func shipsFitting(space dimensionalCount: DimensionalCount) -> [(Ship, Direction)] {
        return [
            shipsByDirection(ships, count: dimensionalCount.left, direction: .left),
            shipsByDirection(ships, count: dimensionalCount.up, direction: .up),
            shipsByDirection(ships, count: dimensionalCount.right, direction: .right),
            shipsByDirection(ships, count: dimensionalCount.down, direction: .down)
        ].flatMap { $0 }
    }

    private func shipsByDirection(_ ships: [Ship],
                                  count: Int,
                                  direction: Direction) -> [(Ship, Direction)] {
        ships.filter { ship in
            ship.length <= count
        }.map {
            ($0, direction)
        }
    }

    init(ships: [Ship]) {
        self.ships = ships
    }
}
