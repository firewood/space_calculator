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
        let radius:CGFloat = 10.0
        self.init()
        let size = CGSize(width: radius * 0.25, height: radius * 1.5)
        self.init(ellipseOfSize: size)
        position = CGPointMake(player.position.x, 52.0);
        fillColor = SKColor.whiteColor()
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        physicsBody?.affectedByGravity = false
        physicsBody?.velocity = CGVectorMake(0, 384)
        stage.addChild(self)
    }

}
