//
//  Computation.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/17.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

class Computation {

    init() {
    }

    var background: SKSpriteNode?
    var text: SKLabelNode?

    func setup(stage: SKScene) {
        background = SKSpriteNode(color: SKColor.grayColor(), size: CGSize(width: stage.size.width, height: 60))
        background!.anchorPoint.x = 0
        background!.anchorPoint.y = 0
        background!.position = CGPoint(x: 0, y: stage.size.height - 60)
        background!.zPosition = 1000000000
        stage.addChild(background!)

        text = SKLabelNode(text: "0")
        text!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        text!.position = CGPoint(x: stage.size.width - 10, y: stage.size.height - 50)
        text!.zPosition = 1000000001
        stage.addChild(text!)
    }

}
