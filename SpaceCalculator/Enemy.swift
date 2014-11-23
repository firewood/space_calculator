//
//  Enemy.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

enum MathOperator {
    case Digit, Plus, Minus, Mul, Div, Equal
}

class Enemy: SKSpriteNode {

    convenience init(name: String) {
        self.init(imageNamed: "button" + name)
        setScale(0.5)
    }

/*
    deinit {
        println("Enemy destroyed")
    }
*/

    class func generateRandomly() -> Enemy {
        var enemy:Enemy?
        let type = arc4random_uniform(16)
        switch (type) {
        case 10:
            enemy = PlusEnemy()
        case 11:
            enemy = MinusEnemy()
        case 12:
            enemy = MulEnemy()
        case 13:
            enemy = DivEnemy()
        case 14:
            enemy = EqualEnemy()
        case 15:
            enemy = ClearEnemy()
        default:
            enemy = DigitEnemy(digit: Int(type))
        }
        return enemy!
    }

    func fall() {
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width - 10, height: size.height - 10))
        physicsBody!.affectedByGravity = false
        physicsBody!.velocity = CGVectorMake(0, -150)
        physicsBody!.categoryBitMask = enemyCategory

        let waitAction = SKAction.waitForDuration(10)
        let removeAction = SKAction.removeFromParent()
        let sequence = [waitAction, removeAction]
        runAction(SKAction.sequence(sequence))
    }

    func getValue() -> String {
        return ""
    }

}
