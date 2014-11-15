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
    var player: SKSpriteNode?

    func setupPlayer() {
        player = SKSpriteNode(imageNamed: "Spaceship")
        player!.position = CGPointMake(CGRectGetMidX(self.frame), 40.0);
        player!.setScale(0.1)
        self.addChild(player!)

    }

    override func didMoveToView(view: SKView) {
        setupPlayer()

    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {

        close!.closeScene(self)

    }

}
