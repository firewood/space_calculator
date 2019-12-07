//
//  ViewController.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/15.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var DebugButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapStartButton(_ sender: AnyObject) {
        // start a new game
        showScene(Stage(size: view.frame.size))
    }

    @IBAction func didTapDebugButton(_ sender: AnyObject) {
        // show debug console :)
        showScene(DebugStage(size: view.frame.size))
    }

    func showScene(_ scene: SKScene) {
        let skView:SKView = SKView(frame: view.frame)
        skView.ignoresSiblingOrder = true
        view.addSubview(skView)
        scene.scaleMode = SKSceneScaleMode.aspectFill
        skView.presentScene(scene)
    }
}
