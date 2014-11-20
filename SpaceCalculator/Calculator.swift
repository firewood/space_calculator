//
//  Calculator.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/20.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import Foundation

class Calculator {

    class func evaluatePostfix(rpn:[String]) ->Double {
        var stack:[Double] = []
        func ALU(f:((Double, Double) -> Double)) -> Double {
            if (stack.isEmpty) {
                stack.append(0)
            }
            if (stack.count < 2) {
                stack.append(stack.first!)
            }
            var a:Double = stack.last!
            stack.removeLast()
            var b:Double = stack.last!
            stack.removeLast()
            return f(a, b)
        }
        for c in rpn {
            switch (c) {
            case "+":
                stack.append(ALU({$1 + $0}))
            case "-":
                stack.append(ALU({$1 - $0}))
            case "*":
                stack.append(ALU({$1 * $0}))
            case "/":
                stack.append(ALU({$1 / $0}))
            default:
                let s:NSString = NSString(string: c)
                stack.append(s.doubleValue)
            }
        }
        return stack.last!
    }

    class func infixToPostfix(commands:[String]) -> [String] {
        var result:[String] = []
        var op:[String] = []
        func flush_op() {
            while (op.count > 0) {
                result.append(op.last!)
                op.removeLast()
            }
        }
        for c in commands {
            switch (c) {
            case "+","-":
                flush_op()
                op.append(String(c))
            case "*","/":
                op.append(String(c))
            default:
                result.append(c)
            }
        }
        flush_op()
        return result
    }

    class func stringToInfix(commands:String) -> [String] {
        var n:String = ""
        var result:[String] = []
        func flush_number() {
            if (n.utf16Count > 0) {
                result.append(n)
                n = ""
            }
        }
        for c in commands {
            switch (c) {
            case "+","-","*","/":
                flush_number()
                result.append(String(c))
            default:
                n += String(c)
            }
        }
        flush_number()
        return result
    }

}
