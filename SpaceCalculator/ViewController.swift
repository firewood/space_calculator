//
//  ViewController.swift
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/15.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController, CloseProtocol {
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var DebugButton: UIButton!
    var skView: SKView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapStartButton(sender: AnyObject) {
        // start a new game
        let s = Stage(size: view.frame.size)
        s.close = self
        s.scaleMode = SKSceneScaleMode.AspectFill
        skView = SKView(frame: view.frame)
        skView!.presentScene(s)
        view.addSubview(skView!)
    }

    @IBAction func didTapDebugButton(sender: AnyObject) {
        // show debug console :)
        let s = DebugStage(size: view.frame.size)
        s.close = self
        s.scaleMode = SKSceneScaleMode.AspectFill
        skView = SKView(frame: view.frame)
        skView!.presentScene(s)
        view.addSubview(skView!)
    }

    func onClose() {
        skView!.removeFromSuperview()
        skView = nil
    }
}
