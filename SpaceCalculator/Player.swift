//
//  Player.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {

    convenience override init() {
        self.init(imageNamed: "Spaceship")
        setScale(0.1)
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody!.affectedByGravity = false
        physicsBody!.categoryBitMask = playerCategory
        physicsBody!.contactTestBitMask = enemyCategory
        physicsBody!.collisionBitMask = enemyCategory
        speed = 100
    }

}
