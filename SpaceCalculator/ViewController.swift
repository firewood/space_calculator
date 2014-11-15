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
    var skView: SKView?
    var stage: Stage?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTap(sender: AnyObject) {
        println("Tapped")

        let s = Stage(size: view.frame.size)
        s.close = self
        s.scaleMode = SKSceneScaleMode.AspectFill
        skView = SKView(frame: view.frame)
        skView!.showsFPS = true
        skView!.presentScene(s)
        view.addSubview(skView!)
    }

    func closeScene(scene: SKScene) {
        println("Closed")
        skView!.removeFromSuperview()

    }

}

