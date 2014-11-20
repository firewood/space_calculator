//
//  Computation.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/17.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

class Computation {
    var queue:[String] = []
    var currentValue:Double = 0
    var isFirst:Bool = true
    var background:SKSpriteNode?
    var text:SKLabelNode?

    init(stage: SKScene) {
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

    func getCurrentText() -> String {
        switch (currentValue) {
        case 0:
            return "0"
        case Double.infinity:
            return "∞"
        case Double.NaN:
            return "NaN"
        default:
            break
        }

        if (fabs(currentValue) > 1.0E+10 || fabs(currentValue) < 1.0E-10) {
            return String(format: "%.10E", currentValue)
        }

        var s:String = String(format: "%.12lf", currentValue)
        while (s.hasSuffix("0")) {
            s.removeAtIndex(s.endIndex.predecessor())
        }
        if (s.hasSuffix(".")) {
            s.removeAtIndex(s.endIndex.predecessor())
        }
        return s
    }

    func updateText() {
        text!.text = getCurrentText()
    }

    func onEqual() {
        let rpn:[String] = Calculator.infixToPostfix(queue)
        currentValue = Calculator.evaluatePostfix(rpn)
        queue = []
    }

    func registerEnemy(enemy: Enemy) {
        let v:String = enemy.getValue()
        switch (v) {
        case "+", "-", "*", "/":
            println("push: " + getCurrentText() + ", " + v)
            queue.append(getCurrentText())
            queue.append(v)
            isFirst = true
        case "=":
            println("push: " + getCurrentText())
            queue.append(getCurrentText())
            onEqual()
            isFirst = true
        default:
            if (isFirst) {
                isFirst = false
                currentValue = 0
            } else {
                currentValue *= 10
            }
            currentValue += (v as NSString).doubleValue
        }
        updateText()
    }

}
