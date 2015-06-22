//
//  PlusEnemy.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

class PlusEnemy: Enemy {

    convenience init() {
        self.init(name: "Plus")
    }

    override func getValue() -> String {
        return "+"
    }

}
