//
//  PlusEnemy.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

class PlusEnemy: Enemy {

    convenience init(stage: Stage) {
        self.init()
        Enemy.init(stage: stage, name: "Plus")
    }

}
