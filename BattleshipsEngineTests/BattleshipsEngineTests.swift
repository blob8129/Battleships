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

    func testTopLeftOccupied() {
        let engine = Engine()
        let topLeftCoordinate = Coordinate(vertical: 0, horizontal: 0)

        let firstVSecondHCoordinate = Coordinate(vertical: 0, horizontal: 1)
        let firstVSecondHCount = DimensionalCount(left: 1, top: 1, right: 8, bottom: 9)
        let secondVFirstHCoordinate = Coordinate(vertical: 1, horizontal: 0)
        let secondVFirstHCount = DimensionalCount(left: 1, top: 1, right: 9, bottom: 8)
        let firstVLastHCoordinate = Coordinate(vertical: 0, horizontal: 8)
        let firstVLastHCount = DimensionalCount(left: 8, top: 1, right: 1, bottom: 9)

        engine.fillPlace(at: topLeftCoordinate, with: .ship)

        XCTAssertEqual(engine.freePlaces(from: topLeftCoordinate), DimensionalCount.zero)
        XCTAssertEqual(engine.freePlaces(from: firstVSecondHCoordinate), firstVSecondHCount)
        XCTAssertEqual(engine.freePlaces(from: secondVFirstHCoordinate), secondVFirstHCount)
        XCTAssertEqual(engine.freePlaces(from: firstVLastHCoordinate), firstVLastHCount)
    }

    func testSecondVFirstHOccupied() {
        let engine = Engine()
        let secondVFirstHCoordinate = Coordinate(vertical: 1, horizontal: 0)

        let firstVFirstHCoordinate = Coordinate(vertical: 0, horizontal: 0)
        let firstVFirstHCount = DimensionalCount(left: 1, top: 1, right: 9, bottom: 1)
        let secondVSecondHCoordinate = Coordinate(vertical: 1, horizontal: 1)
        let secondVSecondHCount = DimensionalCount(left: 1, top: 2, right: 8, bottom: 8)
        let thirdVFirstHCoordinate = Coordinate(vertical: 2, horizontal: 0)
        let thirdVFirstHCount = DimensionalCount(left: 1, top: 1, right: 9, bottom: 7)
        let lastVFirstHCoordinate = Coordinate(vertical: 8, horizontal: 0)
        let lastVFirstHCount = DimensionalCount(left: 1, top: 7, right: 9, bottom: 1)

        engine.fillPlace(at: secondVFirstHCoordinate, with: .ship)

        XCTAssertEqual(engine.freePlaces(from: secondVFirstHCoordinate), DimensionalCount.zero)
        XCTAssertEqual(engine.freePlaces(from: firstVFirstHCoordinate), firstVFirstHCount)
        XCTAssertEqual(engine.freePlaces(from: secondVSecondHCoordinate), secondVSecondHCount)
        XCTAssertEqual(engine.freePlaces(from: thirdVFirstHCoordinate), thirdVFirstHCount)
        XCTAssertEqual(engine.freePlaces(from: lastVFirstHCoordinate), lastVFirstHCount)
    }

    func testPlaceHShipTopLeft() {
        let engine = Engine()

        engine.place(Ship(length: 5),
                     at: Coordinate(vertical: 0, horizontal: 0),
                     direction: .left)

        XCTAssertEqual(engine.battleField[0],
                  [.ship, .ship, .ship, .ship, .ship, .empty, .empty, .empty, .empty])
    }

    func testPlaceHShipMiddle() {
        let engine = Engine()

        engine.place(Ship(length: 2),
                     at: Coordinate(vertical: 5, horizontal: 5),
                     direction: .left)

        XCTAssertEqual(engine.battleField[5],
                  [.empty, .empty, .empty, .empty, .empty, .ship, .ship, .empty, .empty])
    }


    func testLeftDown() {
        let engine = Engine()

        engine.place(Ship(length: 2),
                          at: Coordinate(vertical: 0, horizontal: 0),
                          direction: .left)

        engine.place(Ship(length: 1),
                          at: Coordinate(vertical: 0, horizontal: 8),
                          direction: .left)

        engine.place(Ship(length: 2),
                          at: Coordinate(vertical: 0, horizontal: 5),
                          direction: .left)

        engine.place(Ship(length: 5),
                          at: Coordinate(vertical: 0, horizontal: 3),
                          direction: .down)

        engine.place(Ship(length: 2),
                          at: Coordinate(vertical: 4, horizontal: 5),
                          direction: .down)

        engine.place(Ship(length: 2),
                          at: Coordinate(vertical: 7, horizontal: 8),
                          direction: .down)


        XCTAssertEqual(engine.battleField, [
            [.ship, .ship, .empty, .ship, .empty, .ship, .ship, .empty, .ship],
            [.empty, .empty, .empty, .ship, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .ship, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .ship, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .ship, .empty, .ship, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .ship, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .ship],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .ship]
        ])
    }

    func testUp() {
        let engine = Engine()

        engine.place(Ship(length: 2),
                          at: Coordinate(vertical: 8, horizontal: 0),
                          direction: .up)

        engine.place(Ship(length: 1),
                          at: Coordinate(vertical: 8, horizontal: 8),
                          direction: .up)

        engine.place(Ship(length: 5),
                          at: Coordinate(vertical: 5, horizontal: 7),
                          direction: .up)

        engine.place(Ship(length: 1),
                          at: Coordinate(vertical: 0, horizontal: 0),
                          direction: .up)

        XCTAssertEqual(engine.battleField, [
            [.ship, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .ship, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .ship, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .ship, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .ship, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .ship, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.ship, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.ship, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .ship]
        ])
    }

    func testRight() {
        let engine = Engine()

        engine.place(Ship(length: 4),
                     at: Coordinate(vertical: 0, horizontal: 3),
                     direction: .right)

        engine.place(Ship(length: 1),
                     at: Coordinate(vertical: 2, horizontal: 0),
                     direction: .right)

        engine.place(Ship(length: 3),
                     at: Coordinate(vertical: 8, horizontal: 6),
                     direction: .right)

        engine.place(Ship(length: 1),
                     at: Coordinate(vertical: 8, horizontal: 0),
                     direction: .right)

        XCTAssertEqual(engine.battleField, [
            [.ship, .ship, .ship, .ship, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.ship, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
            [.ship, .empty, .empty, .empty, .ship, .ship, .ship, .empty, .empty]
        ])
    }
}
