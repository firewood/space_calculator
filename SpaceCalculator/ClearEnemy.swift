//
//  ClearEnemy.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

class ClearEnemy: Enemy {

    convenience init() {
        self.init(name: "Clear")
    }

    override func getValue() -> String {
        return "C"
    }

}
