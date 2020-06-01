//
//  FleetManagerTests.swift
//  BattleshipsEngineTests
//
//  Created by Andrey Volobuev on 01/06/2020.
//  Copyright © 2020 Andrey Volobuev. All rights reserved.
//

import XCTest
@testable import BattleshipsEngine

class FleetManagerTests: XCTestCase {

    func testShipsFittingSpace() {

        let fleetManager = FleetManager(ships: [1, 2, 3, 4, 5].map { Ship(length: $0) })

        let shipsFittingSpace = fleetManager
            .shipsFitting(space: DimensionalCount(left: 3, up: 1, right: 9, down: 0))

        let shipsFittingSpaceLeft = shipsFittingSpace.filter { $0.1 == .left }.map { $0.0 }
        let shipsFittingSpaceUp = shipsFittingSpace.filter { $0.1 == .up }.map { $0.0 }
        let shipsFittingSpaceRight = shipsFittingSpace.filter { $0.1 == .right }.map { $0.0 }
        let shipsFittingSpaceDown = shipsFittingSpace.filter { $0.1 == .down }.map { $0.0 }

        XCTAssertTrue(shipsFittingSpaceLeft.contains(Ship(length: 1)))
        XCTAssertTrue(shipsFittingSpaceLeft.contains(Ship(length: 2)))
        XCTAssertTrue(shipsFittingSpaceLeft.contains(Ship(length: 3)))
        XCTAssertFalse(shipsFittingSpaceLeft.contains(Ship(length: 4)))

        XCTAssertTrue(shipsFittingSpaceUp.contains(Ship(length: 1)))
        XCTAssertFalse(shipsFittingSpaceUp.contains(Ship(length: 2)))

        XCTAssertTrue(shipsFittingSpaceRight.contains(Ship(length: 1)))
        XCTAssertTrue(shipsFittingSpaceRight.contains(Ship(length: 2)))
        XCTAssertTrue(shipsFittingSpaceRight.contains(Ship(length: 3)))
        XCTAssertTrue(shipsFittingSpaceRight.contains(Ship(length: 4)))
        XCTAssertTrue(shipsFittingSpaceRight.contains(Ship(length: 5)))
        XCTAssertFalse(shipsFittingSpaceRight.contains(Ship(length: 6)))

        XCTAssertFalse(shipsFittingSpaceDown.contains(Ship(length: 1)))
    }
}
