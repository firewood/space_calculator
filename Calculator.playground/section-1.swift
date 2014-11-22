// Playground - noun: a place where people can play

import UIKit

class Calculator {
    var currentValue:Double = 0
    var infixQueue:[String] = []
    var lastOp:[String] = []

    func clearAll() {
        currentValue = 0
        clearQueue()
    }

    func clearQueue() {
        infixQueue.removeAll(keepCapacity: false)
    }

    class func evaluatePostfix(initialValue:Double, rpn:[String]) ->Double {
        var stack:[Double] = [initialValue]
        func ALU(f:((Double, Double) -> Double)) -> Double {
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

    func execute() -> Double {
        switch (infixQueue.count) {
        case 0:
            infixQueue = lastOp
        case 1:
            break
        default:
            lastOp = [infixQueue[infixQueue.count-2], infixQueue.last!]
        }

        var rpnQueue:[String] = Calculator.infixToPostfix(infixQueue)
        println("rpnQueue: \(rpnQueue)")
        currentValue = Calculator.evaluatePostfix(currentValue, rpn:rpnQueue)
        return currentValue
    }

    func execute(commands:String) -> Double {
        infixQueue = Calculator.stringToInfix(commands)
        println("infixQueue: \(infixQueue)")
        return execute()
    }

}

var c:Calculator = Calculator()

c.clearAll()
c.execute("1+2*3")      // 7.0

c.clearAll()
c.execute("1*2+3")      // 5.0

c.clearAll()
c.execute("1-2*3*4-5")      // 28.0
c.execute("")               // -33.0
c.execute("*")              // 1089.0
c.execute("7")              // 7.0

c.clearAll()
c.execute("1+3*5*")
