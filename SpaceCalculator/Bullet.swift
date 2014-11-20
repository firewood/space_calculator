//
//  Bullet.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

class Bullet: SKShapeNode {

    convenience init(radius:CGFloat) {
        let size = CGSize(width: radius * 0.5, height: radius * 2.5)
        self.init()
        self.init(ellipseOfSize: size)
        fillColor = SKColor.whiteColor()
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: radius * 0.5, height: radius * 2))
        physicsBody?.affectedByGravity = false
        physicsBody?.velocity = CGVectorMake(0, 384)
        physicsBody!.categoryBitMask = bulletCategory
        physicsBody!.contactTestBitMask = enemyCategory
        physicsBody!.collisionBitMask = enemyCategory
    }

}
