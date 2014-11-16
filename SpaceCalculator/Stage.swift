//
//  Stage.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/15.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import SpriteKit

protocol CloseProtocol {
    func closeScene(scene: SKScene)
}

class Stage: SKScene {

    var close: CloseProtocol?
    var player: Player?
    var enemy: Enemy?
    var isPlayerMoving: Bool = false
    var playerMovedDistance: Float = 0
    var computation: Computation?

    override func didMoveToView(view: SKView) {
        computation = Computation()
        computation!.setup(self)

        player = Player(stage: self)
//        enemy = DigitEnemy(stage: self, digit: 2)
        enemy = PlusEnemy(stage: self)

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
            player!.fire()
        }
    }

}
