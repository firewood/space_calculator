//
//  DigitEnemy.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

class DigitEnemy: Enemy {

    var digit: Int?

    convenience init(digit: Int) {
        self.init(name: String(digit))
        self.digit = digit
    }

    override func getValue() -> String {
        return String(digit!)
    }

}
