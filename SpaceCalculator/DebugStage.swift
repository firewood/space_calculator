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

    override func didMove(to view: SKView) {
        computation = Computation(stage: self)

        var enemies:[Enemy?] = [
            DigitEnemy(digit: 0), nil, nil, EqualEnemy(),
            DigitEnemy(digit: 1), DigitEnemy(digit: 2), DigitEnemy(digit: 3), MinusEnemy(),
            DigitEnemy(digit: 4), DigitEnemy(digit: 5), DigitEnemy(digit: 6), PlusEnemy(),
            DigitEnemy(digit: 7), DigitEnemy(digit: 8), DigitEnemy(digit: 9), MulEnemy(),
            ClearEnemy(), nil, nil, DivEnemy()
        ]

        let horizontal:CGFloat = 75
        let left:CGFloat = (size.width - CGFloat(horizontal) * (4-1)) / 2
        let vertical:CGFloat = 60
        let top:CGFloat = (size.height - computation!.background!.frame.height - CGFloat(vertical) * (5-1)) / 2

        for i in 0 ..< enemies.count {
            let enemy:Enemy? = enemies[i]
            if (enemy != nil) {
                enemy?.position = CGPoint(x: CGFloat(i % 4) * horizontal + left, y: CGFloat(i / 4) * vertical + top)
                addChild(enemy!)
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let node:SKNode? = atPoint(location)
            if (node != nil && node!.isKind(of: Enemy.self)) {
                let command:String = (node! as! Enemy).getValue()
                computation!.press(command)
            }
        }
    }
}
