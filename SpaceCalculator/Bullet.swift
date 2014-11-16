//
//  Bullet.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

class Bullet: SKShapeNode {

    convenience init(stage: SKScene, player: SKSpriteNode) {
        let radius:CGFloat = 3
        self.init()
        self.init(circleOfRadius: radius)
        position = CGPointMake(player.position.x, 45.0);
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        physicsBody?.affectedByGravity = false
        physicsBody?.velocity = CGVectorMake(0, 384)
        stage.addChild(self)
    }

}
