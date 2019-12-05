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
let newEnemyInterval:Double = 1.0

// protocol to close scene
protocol CloseProtocol {
    func onClose()
}

class Stage: SKScene, SKPhysicsContactDelegate {
    var close: CloseProtocol?
    var computation: Computation?       // score board
    var player: Player?
    var timer:Timer?
    var isPlaying:Bool = true
    var isPlayerMoving: Bool = false
    var playerMovedDistance: Float = 0
    var nextEnemy: Double = 0
    var previousEnemyLeft:CGFloat = 0

    deinit {
        print("Stage destroyed")
    }

    func setupComputation() {
        // generate score board on top
        computation = Computation(stage: self)
    }

    func setupPlayer() {
        player = Player()
        player!.position = CGPoint(x: frame.midX, y: 30.0);
        addChild(player!)
    }

    func setupEnemy() {
        // generate new random enemy on top
        let enemy:Enemy = Enemy.generateRandomly()
        while (true) {
            // keep new enemy away from previous one
            let left:CGFloat = CGFloat(arc4random_uniform(UInt32(size.width - enemy.size.width))) + enemy.size.width / 2
            if (fabs(previousEnemyLeft - left) >= 120) {
                enemy.position = CGPoint(x: left, y: size.height)
                enemy.fall()
                addChild(enemy)
                previousEnemyLeft = left
                break
            }
        }
        nextEnemy = newEnemyInterval
    }

    // generate explosion effect
    func setupExplosion(_ position:CGPoint, scale:CGFloat, duration:TimeInterval) {
        // alternative to SKEmitterNode:filenamed
        let ex:SKEmitterNode = NSKeyedUnarchiver.unarchiveObject(withFile: Bundle.main.path(forResource: "Explosion", ofType: "sks")!) as! SKEmitterNode
        ex.xScale = scale
        ex.yScale = scale
        ex.position = position
        addChild(ex)
        let fadeOutAction = SKAction.fadeOut(withDuration: duration)
        let removeAction = SKAction.removeFromParent()
        let sequence = [fadeOutAction, removeAction]
        ex.run(SKAction.sequence(sequence))
    }

    // burn the player
    func destroyPlayer() {
        if (player != nil) {
            setupExplosion(player!.position, scale: 0.3, duration: 0.5)
        }
    }

    // burn the enemy
    func destroyEnemy(_ enemy:SKNode) {
        setupExplosion(enemy.position, scale: 0.2, duration: 0.3)
        enemy.removeFromParent()
    }

    // show result banner
    func banner(_ s:String) {
        let text:SKLabelNode = SKLabelNode()
        text.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        text.position = CGPoint(x: size.width / 2, y: size.height / 2)
        text.zPosition = 1000000002
        text.text = s
        text.alpha = 0
        addChild(text)
        let fadeInAction = SKAction.fadeIn(withDuration: 5)
        let sequence = [fadeInAction]
        text.run(SKAction.sequence(sequence))
        nextEnemy = 2       // guard timer
    }

    // game overflow
    func overflow() {
        destroyPlayer()
        if (isPlaying) {
            isPlaying = false
            banner("Game Overflow")
        }
    }

    // game cleared
    func clear() {
        isPlaying = false
        banner("CLEAR!!")
    }

    // initialization
    override func didMove(to view: SKView) {
        setupComputation()
        setupPlayer()
        setupEnemy()
        timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true, block: { _ in self.onTimer() })
        self.physicsWorld.contactDelegate = self
    }

    // touch start
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isPlaying) {
            return      // game is over
        }

        isPlayerMoving = false
        playerMovedDistance = 0

        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let node:SKNode? = atPoint(location)
            if (node == player!) {
                // start moving
                isPlayerMoving = true
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isPlaying || !isPlayerMoving) {
            return
        }

        // player is in dragging
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let diff: Float = Float(location.x - player!.position.x)
            player!.position.x = location.x
            playerMovedDistance += fabsf(diff)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isPlaying) {
            if (nextEnemy <= 0) {
                // free resources and close
                timer!.invalidate()
                close!.onClose()
            }
            return
        }

        // fire by tap
        if (isPlaying && playerMovedDistance <= 4.0) {
            let bullet = Bullet()
            bullet.position = CGPoint(x: player!.position.x, y: 45.0);
            addChild(bullet)
        }
    }

    // collision handling
    func didBegin(_ contact: SKPhysicsContact!) {
        var pBody, eBody: SKPhysicsBody
        pBody = contact.bodyA
        eBody = contact.bodyB
        if (pBody.categoryBitMask == enemyCategory) {
            // make eBody be enemy
            swap(&pBody, &eBody)
        }
        if (pBody.categoryBitMask == playerCategory) {
            print("Player hit")
            overflow()
        }
        if (pBody.categoryBitMask == bulletCategory) {
//            println("Bullet")
            pBody.node!.removeFromParent()

            // send enemy command to score board
            let command:String = (eBody.node as! Enemy).getValue()
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

    // adding new enemy every newEnemyInterval
    func onTimer() {
        nextEnemy -= timerInterval
        if (isPlaying && nextEnemy <= 0) {
            setupEnemy()
        }
    }
}
