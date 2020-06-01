//
//  Engine+UIKit.swift
//  BattleshipsEngine
//
//  Created by Andrey Volobuev on 02/06/2020.
//  Copyright © 2020 Andrey Volobuev. All rights reserved.
//

import UIKit

public extension Engine {
    subscript(_ indexPath: IndexPath) -> Place {
        get {
            self.battleField[indexPath.section][indexPath.row]
        } set(newValue) {
            self.battleField[indexPath.section][indexPath.row] = newValue
        }
    }
}
