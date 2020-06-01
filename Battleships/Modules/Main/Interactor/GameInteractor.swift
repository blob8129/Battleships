//
//  GameInteractor.swift
//  Battleships
//
//  Created by Andrey Volobuev on 02/06/2020.
//  Copyright © 2020 Andrey Volobuev. All rights reserved.
//

import BattleshipsEngine

protocol GameInteractorInput {
    func item(at indexPath: IndexPath) -> Place
    func didSelectFieldItem(at indexPath: IndexPath)
    func didSelectShip(at index: Int)
    func didSelectDirection(at index: Int)
}

protocol GameInteractorOutput: class {
    func reload()
    func renderShipLengthSelector(isEnabled: [Bool])
    func renderDirectionSelector(isEnabled: [Bool])
}

final class GameInteractor: GameInteractorInput {

    private let engine = Engine()
    private let fleetManager = FleetManager(ships: [1, 2, 3, 4, 5].map { Ship(length: $0) })
    weak var view: GameInteractorOutput?

    private var directionByShipLength: [Int : [(Ship, Direction)]]?
    private let allDirections: [Direction] = [.left, .up, .right, .down]
    private var currentIndexPath: IndexPath?
    private var lengthIndex: Int?

    // MARK: GameInteractorInput
    func item(at indexPath: IndexPath) -> Place {
        engine[indexPath]
    }

    func didSelectFieldItem(at indexPath: IndexPath) {
        currentIndexPath = indexPath
        let freePlaces = engine.freePlaces(from: Coordinate(indexPath))
        let availableShips = fleetManager.shipsFitting(space: freePlaces)
        directionByShipLength = Dictionary(grouping: availableShips) { shipDirection -> Int in
            let (ship, _) = shipDirection
            return ship.length
        }
        view?.renderShipLengthSelector(isEnabled: (1...5).map {
            directionByShipLength?.keys.contains($0) == true
        })
    }

    func didSelectShip(at index: Int) {
        lengthIndex = index
        if let currentIndexPath = currentIndexPath, index == 0 {
            engine.place(Ship(length: 1), at: Coordinate(currentIndexPath), direction: .down)
            reloadView()
            return
        }
        guard let directionByShipLength = directionByShipLength else { return }
        let directions = directionByShipLength[index + 1]?.compactMap { $0.1 } ?? []

        view?.renderDirectionSelector(isEnabled: allDirections.map { directions.contains($0) })
    }

    func didSelectDirection(at index: Int) {
        guard let currentIndexPath = currentIndexPath, let lengthIndex = lengthIndex else { return }
        engine.place(Ship(length: lengthIndex + 1),
                     at: Coordinate(currentIndexPath),
                     direction: allDirections[index])
        reloadView()
    }

    private func reloadView() {
        currentIndexPath = nil
        lengthIndex = nil
        view?.reload()
    }
}
