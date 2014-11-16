//
//  DigitEnemy.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

class DigitEnemy: Enemy {

    var digit: Int?

    convenience init(stage: Stage, digit: Int) {
        self.init()
        Enemy.init(stage: stage, name: String(digit))
        self.digit = digit
    }



}
