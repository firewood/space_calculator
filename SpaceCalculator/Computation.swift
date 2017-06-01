//
//  Computation.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/17.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

// score board class
class Computation {
    var calc:Calculator = Calculator()      // calculator
    var currentValue:Double = 0             // current score
    var isFirst:Bool = true                 // first character is entered
    var mathOp:String = ""
    var background:SKSpriteNode?
    var text:SKLabelNode?

    init(stage: SKScene) {
        background = SKSpriteNode(color: SKColor.gray, size: CGSize(width: stage.size.width, height: 60))
        background!.anchorPoint.x = 0
        background!.anchorPoint.y = 0
        background!.position = CGPoint(x: 0, y: stage.size.height - 60)
        background!.zPosition = 1000000000
        stage.addChild(background!)

        text = SKLabelNode()
        text!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        text!.position = CGPoint(x: stage.size.width - 10, y: stage.size.height - 50)
        text!.zPosition = 1000000001
        stage.addChild(text!)
        updateText()
    }

    // stringify current score
    func getCurrentText() -> String {
        // 0 or infinity
        switch (currentValue) {
        case 0:
            return "0"
        case Double.infinity:
            return "∞"
        case -Double.infinity:
            return "-∞"
        case Double.nan:
            return "NaN"
        default:
            break
        }

        // too big or too small
        if (fabs(currentValue) >= 1.0E+14 || fabs(currentValue) < 1.0E-12) {
            return String(format: "%.10E", currentValue)
        }

        // others
        // strip trailing zeros
        var s:String = String(format: "%.12lf", currentValue)
        while (s.hasSuffix("0")) {
            s.remove(at: s.characters.index(before: s.endIndex))
        }
        if (s.hasSuffix(".")) {
            s.remove(at: s.characters.index(before: s.endIndex))
        }
        return s
    }

    func updateText() {
        text!.text = getCurrentText()
    }

    // emit one character and update
    func press(_ command:String) {
        print("queue: \(calc.infixQueue), result: \(currentValue), add: \(command)")

        switch (command) {
        case "C":
            calc.clearAll()
            currentValue = 0
            isFirst = true
            mathOp = ""
        case "+", "-":
            // if no digits are given, current value will be used for calculation
            if (!isFirst) {
                calc.infixQueue.append(String(getCurrentText()))
                // calculate whole expressions because other expressions have higher priority
                currentValue = calc.execute()
            }
            isFirst = true
            mathOp = command
        case "*", "/":
            if (!isFirst) {
                calc.infixQueue.append(String(getCurrentText()))
                // Update calc's implicit operand to get 64 from "8*=".
                // Do not calculate whole expressions to conform regular calculator's behavior.
                // FIXME: overflow detection
                calc.currentValue = currentValue
            }
            isFirst = true
            mathOp = command
        case "=":
            if (!isFirst) {
                // Flush the operand buffer
                calc.infixQueue.append(String(getCurrentText()))
            }
            if (!mathOp.isEmpty) {
                // Last operand is not given explicitly.
                // Flush the arithmetic operator buffer.
                calc.infixQueue.append(mathOp)
                // Previous value will be implicit operand.
                calc.infixQueue.append(String(getCurrentText()))
            }

            currentValue = calc.execute()
            isFirst = true
            mathOp = ""
            calc.infixQueue = []
        default:
            if (!isFirst && currentValue >= 1.0E+13) {
                return
            }

            if (!mathOp.isEmpty) {
                calc.infixQueue.append(mathOp)
                mathOp = ""
            }
            if (isFirst) {
                isFirst = false
                currentValue = 0
            } else {
                currentValue *= 10
            }
            currentValue += (command as NSString).doubleValue
        }
        updateText()
    }
}
