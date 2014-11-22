//
//  DebugStage.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/15.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

class DebugStage: SKScene {
    var close: CloseProtocol?
    var computation: Computation?

    override func didMoveToView(view: SKView) {
        computation = Computation(stage: self)

        var enemies:[Enemy?] = [
            DigitEnemy(digit: 0), nil, nil, EqualEnemy(),
            DigitEnemy(digit: 1), DigitEnemy(digit: 2), DigitEnemy(digit: 3), MinusEnemy(),
            DigitEnemy(digit: 4), DigitEnemy(digit: 5), DigitEnemy(digit: 6), PlusEnemy(),
            DigitEnemy(digit: 7), DigitEnemy(digit: 8), DigitEnemy(digit: 9), MulEnemy(),
            nil, nil, nil, DivEnemy()
        ]

        for (var i = 0; i < enemies.count; i++) {
            let enemy:Enemy? = enemies[i]
            if (enemy != nil) {
                enemy?.position = CGPointMake(CGFloat(i % 4) * 75 + 50, CGFloat(i / 4) * 50 + 100)
                addChild(enemy!)
            }
        }
    }

    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node:SKNode? = nodeAtPoint(location)
            if (node != nil && node!.isKindOfClass(Enemy)) {
                println("pressed: " + (node! as Enemy).getValue())
                computation!.registerEnemy(node! as Enemy)
            }
        }
    }
}
