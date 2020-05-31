//
//  BattleshipsEngineTests.swift
//  BattleshipsEngineTests
//
//  Created by Andrey Volobuev on 30/05/2020.
//  Copyright © 2020 Andrey Volobuev. All rights reserved.
//

import XCTest
@testable import BattleshipsEngine

class BattleshipsEngineTests: XCTestCase {

    func testInitialAvailablePlaces() {
        let engine = Engine()

        XCTAssertEqual(engine.battleField, [
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty]
        ])
    }

    func testFreePlacesFirstVerticalFirstHorizontal() {
        let engine = Engine()
        let coordinate = Coordinate(vertical: 0, horizontal: 0)
        let count = DimensionalCount(left: 1, top: 1, right: 9, bottom: 9)

        XCTAssertEqual(engine.freePlaces(from: coordinate), count)
    }

    func testFreePlacesFirstVerticalSecondHorizontal() {
        let engine = Engine()
        let coordinate = Coordinate(vertical: 0, horizontal: 1)
        let count = DimensionalCount(left: 2, top: 1, right: 8, bottom: 9)

        XCTAssertEqual(engine.freePlaces(from: coordinate), count)
    }

    func testFreePlacesSecondVerticalFirstHorizontal() {
        let engine = Engine()
        let coordinate = Coordinate(vertical: 1, horizontal: 0)
        let count = DimensionalCount(left: 1, top: 2, right: 9, bottom: 8)

        XCTAssertEqual(engine.freePlaces(from: coordinate), count)
    }

    func testFreePlacesMiddle() {
        let engine = Engine()
        let coordinate = Coordinate(vertical: 5, horizontal: 5)
        let count = DimensionalCount(left: 6, top: 6, right: 4, bottom: 4)

        XCTAssertEqual(engine.freePlaces(from: coordinate), count)
    }

    func testFreePlacesBottomLeft() {
        let engine = Engine()
        let coordinate = Coordinate(vertical: 8, horizontal: 8)
        let count = DimensionalCount(left: 9, top: 9, right: 1, bottom: 1)

        XCTAssertEqual(engine.freePlaces(from: coordinate), count)
    }

    func testFreePlacesBottomRight() {
        let engine = Engine()
        let coordinate = Coordinate(vertical: 8, horizontal: 8)
        let count = DimensionalCount(left: 9, top: 9, right: 1, bottom: 1)

        XCTAssertEqual(engine.freePlaces(from: coordinate), count)
    }

    func testFreePlacesTopRight() {
        let engine = Engine()
        let coordinate = Coordinate(vertical: 0, horizontal: 8)
        let count = DimensionalCount(left: 9, top: 1, right: 1, bottom: 9)

        XCTAssertEqual(engine.freePlaces(from: coordinate), count)
    }
}
