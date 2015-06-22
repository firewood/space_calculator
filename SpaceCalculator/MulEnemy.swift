//
//  MulEnemy.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

class MulEnemy: Enemy {

    convenience init() {
        self.init(name: "Mul")
    }

    override func getValue() -> String {
        return "*"
    }

}
