//
//  HitTests.swift
//  BattleshipsEngineTests
//
//  Created by Andrey Volobuev on 01/06/2020.
//  Copyright © 2020 Andrey Volobuev. All rights reserved.
//

import XCTest
@testable import BattleshipsEngine

class HitTests: XCTestCase {

    func testHitHorizontal() throws {
        let engine = Engine()
        let coordinate = Coordinate(vertical: 0, horizontal: 1)
        engine.place(Ship(length: 3), at: coordinate, direction: .left)

        engine.fire(at: Coordinate(vertical: 0, horizontal: 0))
        engine.fire(at: Coordinate(vertical: 0, horizontal: 1))
        engine.fire(at: Coordinate(vertical: 0, horizontal: 2))
        engine.fire(at: Coordinate(vertical: 0, horizontal: 3))
        engine.fire(at: Coordinate(vertical: 0, horizontal: 4))
        engine.fire(at: Coordinate(vertical: 0, horizontal: 5))

        XCTAssertEqual(engine.battleField[0, 0], .miss)
        XCTAssertEqual(engine.battleField[0, 1], .hit)
        XCTAssertEqual(engine.battleField[0, 2], .hit)
        XCTAssertEqual(engine.battleField[0, 3], .hit)
        XCTAssertEqual(engine.battleField[0, 4], .miss)
        XCTAssertEqual(engine.battleField[0, 5], .miss)
    }

    func testHitVertical() throws {
        let engine = Engine()
        let coordinate = Coordinate(vertical: 1, horizontal: 1)
        engine.place(Ship(length: 3), at: coordinate, direction: .down)

        engine.fire(at: Coordinate(vertical: 0, horizontal: 1))
        engine.fire(at: Coordinate(vertical: 1, horizontal: 1))
        engine.fire(at: Coordinate(vertical: 2, horizontal: 1))
        engine.fire(at: Coordinate(vertical: 3, horizontal: 1))
        engine.fire(at: Coordinate(vertical: 4, horizontal: 1))
        engine.fire(at: Coordinate(vertical: 5, horizontal: 1))

        XCTAssertEqual(engine.battleField[0, 1], .miss)
        XCTAssertEqual(engine.battleField[1, 1], .hit)
        XCTAssertEqual(engine.battleField[2, 1], .hit)
        XCTAssertEqual(engine.battleField[3, 1], .hit)
        XCTAssertEqual(engine.battleField[4, 1], .miss)
        XCTAssertEqual(engine.battleField[5, 1], .miss)
    }
}
