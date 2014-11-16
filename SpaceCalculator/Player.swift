//
//  Player.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/16.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {

    var stage: SKScene?
    var bullet: Bullet?

    convenience init(stage: SKScene) {
        self.init(imageNamed: "Spaceship")
        self.stage = stage
        position = CGPointMake(CGRectGetMidX(stage.frame), 30.0);
        setScale(0.1)
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.affectedByGravity = false
        speed = 100
        stage.addChild(self)
    }

    func fire() {
        bullet = Bullet(stage: stage!, player: self)
    }

}
