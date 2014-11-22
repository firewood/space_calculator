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
        nextEnemy = 1.5
    }

    func overflow() {
        timer!.invalidate()
        close!.onClose()
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
        if (!isPlayerMoving) {
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
        // fire by tap
        if (playerMovedDistance <= 4.0) {
            let bullet = Bullet(radius: 5.0)
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
            computation!.registerEnemy(eBody.node as Enemy)
            eBody.node!.removeFromParent()
//            nextEnemy = 0
        }
    }

    func onTimer() {
        nextEnemy -= timerInterval
        if (nextEnemy <= 0) {
            setupEnemy()
        }
    }

}
