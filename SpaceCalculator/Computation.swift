//
//  Computation.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/17.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

class Computation {

    var currentValue: Double = 0
    var isFloat: Bool = false
    var background: SKSpriteNode?
    var text: SKLabelNode?

    init() {
    }

    func getCurrentText() -> String {
        let s:String = String(format: "%.0lf", currentValue)
        if (!isFloat) {
            return s
        }
        if (fabs(currentValue) > 1.0E+10 || fabs(currentValue) < 1.0E-10) {
            return String(format: "%.8E", currentValue)
        }
        return String(format: "%.*lf", 12 - s.utf16Count, currentValue)
    }

    func setup(stage: SKScene) {
        background = SKSpriteNode(color: SKColor.grayColor(), size: CGSize(width: stage.size.width, height: 60))
        background!.anchorPoint.x = 0
        background!.anchorPoint.y = 0
        background!.position = CGPoint(x: 0, y: stage.size.height - 60)
        background!.zPosition = 1000000000
        stage.addChild(background!)

        text = SKLabelNode(text: getCurrentText())
        text!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        text!.position = CGPoint(x: stage.size.width - 10, y: stage.size.height - 50)
        text!.zPosition = 1000000001
        stage.addChild(text!)
    }

}
