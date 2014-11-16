//
//  Enemy.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {

    convenience init(stage: SKScene, name: String) {
        self.init(imageNamed: "Button" + name)
        position = CGPointMake(CGRectGetMidX(stage.frame), 400.0);
        setScale(0.5)
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.velocity = CGVectorMake(0, -100)
        stage.addChild(self)
    }

}
