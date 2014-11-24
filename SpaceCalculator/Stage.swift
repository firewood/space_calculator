//
//  Stage.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/15.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

let playerCategory: UInt32 = 1
let bulletCategory: UInt32 = 2
let enemyCategory: UInt32 = 4
let timerInterval:Double = 0.5

protocol CloseProtocol {
    func onClose()
}

class Stage: SKScene, SKPhysicsContactDelegate {
    var close: CloseProtocol?
    var computation: Computation?
    var player: Player?
    var timer:NSTimer?
    var isPlaying:Bool = true
    var isPlayerMoving: Bool = false
    var playerMovedDistance: Float = 0
    var nextEnemy: Double = 0
    var previousEnemyLeft:CGFloat = 0

    deinit {
        println("Stage destroyed")
    }

    func setupComputation() {
        computation = Computation(stage: self)
    }

    func setupPlayer() {
        player = Player()
        player!.position = CGPointMake(CGRectGetMidX(frame), 30.0);
        addChild(player!)
    }

    func setupEnemy() {
        let enemy:Enemy = Enemy.generateRandomly()
        while (true) {
            let left:CGFloat = CGFloat(arc4random_uniform(UInt32(size.width - enemy.size.width))) + enemy.size.width / 2
            if (fabs(previousEnemyLeft - left) >= 120) {
                enemy.position = CGPointMake(left, size.height)
                enemy.fall()
                addChild(enemy)
                previousEnemyLeft = left
                break
            }
        }
        nextEnemy = 1.0
    }

    func setupExplosion(position:CGPoint, scale:CGFloat, duration:NSTimeInterval) {
        let ex:SKEmitterNode = Explosion.generate()
        ex.xScale = scale
        ex.yScale = scale
        ex.position = position
        addChild(ex)
        let fadeOutAction = SKAction.fadeOutWithDuration(duration)
        let removeAction = SKAction.removeFromParent()
        let sequence = [fadeOutAction, removeAction]
        ex.runAction(SKAction.sequence(sequence))
    }

    func destroyPlayer() {
        if (player != nil) {
            setupExplosion(player!.position, scale: 0.3, duration: 0.5)
        }
    }

    func destroyEnemy(enemy:SKNode) {
        setupExplosion(enemy.position, scale: 0.2, duration: 0.3)
        enemy.removeFromParent()
    }

    func banner(s:String) {
        let text:SKLabelNode = SKLabelNode()
        text.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        text.position = CGPoint(x: size.width / 2, y: size.height / 2)
        text.zPosition = 1000000002
        text.text = s
        text.alpha = 0
        addChild(text)
        let fadeInAction = SKAction.fadeInWithDuration(5)
        let sequence = [fadeInAction]
        text.runAction(SKAction.sequence(sequence))
        nextEnemy = 2       // guard timer
    }

    func overflow() {
        destroyPlayer()
        if (isPlaying) {
            isPlaying = false
            banner("Game Overflow")
        }
    }

    func clear() {
        isPlaying = false
        banner("CLEAR!!")
    }

    override func didMoveToView(view: SKView) {
        // initialization
        setupComputation()
        setupPlayer()
        setupEnemy()
        timer = NSTimer.scheduledTimerWithTimeInterval(timerInterval, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        self.physicsWorld.contactDelegate = self
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if (!isPlaying) {
            return
        }

        isPlayerMoving = false
        playerMovedDistance = 0

        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node:SKNode? = nodeAtPoint(location)
            if (node? == player!) {
                // start moving
                isPlayerMoving = true
            }
        }
    }

    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if (!isPlaying || !isPlayerMoving) {
            return
        }

        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let diff: Float = Float(location.x - player!.position.x)
            player!.position.x = location.x
            playerMovedDistance += fabsf(diff)
        }
    }

    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if (!isPlaying) {
            if (nextEnemy <= 0) {
                timer!.invalidate()
                close!.onClose()
            }
            return
        }

        // fire by tap
        if (isPlaying && playerMovedDistance <= 4.0) {
            let bullet = Bullet()
            bullet.position = CGPointMake(player!.position.x, 45.0);
            addChild(bullet)
        }
    }

    func didBeginContact(contact: SKPhysicsContact!) {
        var pBody, eBody: SKPhysicsBody
        pBody = contact.bodyA
        eBody = contact.bodyB
        if (pBody.categoryBitMask == enemyCategory) {
            swap(&pBody, &eBody)
        }
        if (pBody.categoryBitMask == playerCategory) {
            println("Player")
            overflow()
        }
        if (pBody.categoryBitMask == bulletCategory) {
//            println("Bullet")
            pBody.node!.removeFromParent()
            let command:String = (eBody.node as Enemy).getValue()
            computation!.press(command)
            destroyEnemy(eBody.node!)
            if (command == "C") {
                clear()
            }
            switch (computation!.currentValue) {
            case -Double.infinity, Double.infinity:
                overflow()
            default:
                if (computation!.currentValue >= 1.0E+100 || computation!.currentValue <= -1.0E+100) {
                    overflow()
                }
                break
            }
        }
    }

    func onTimer() {
        nextEnemy -= timerInterval
        if (isPlaying && nextEnemy <= 0) {
            setupEnemy()
        }
    }

}
