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
}

protocol GameInteractorOutput: class {
    func reload()
    func render(fittingShips: [(Ship, Direction)])
}

final class GameInteractor: GameInteractorInput {

    private let engine = Engine()
    private let fleetManager = FleetManager(ships: [1, 2, 3, 4, 5].map { Ship(length: $0) })
    weak var view: GameInteractorOutput?

    // MARK: GameInteractorInput
    func item(at indexPath: IndexPath) -> Place {
        engine[indexPath]
    }

    func didSelectFieldItem(at indexPath: IndexPath) {
        let freePlaces = engine.freePlaces(from: Coordinate(indexPath))
        view?.render(fittingShips: fleetManager.shipsFitting(space: freePlaces))
    }
}
