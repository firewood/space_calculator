//
//  Bullet.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

class Bullet: SKSpriteNode {

    convenience override init() {
        self.init(imageNamed: "bullet")
        setScale(0.04)
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody!.affectedByGravity = false
        physicsBody?.velocity = CGVectorMake(0, 500)
        physicsBody!.categoryBitMask = bulletCategory
        physicsBody!.contactTestBitMask = enemyCategory
        physicsBody!.collisionBitMask = enemyCategory
    }

}
