//
//  PlusEnemy.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

class DivEnemy: Enemy {

    convenience override init() {
        self.init(name: "Div")
    }

    override func getValue() -> String {
        return "/"
    }

}
