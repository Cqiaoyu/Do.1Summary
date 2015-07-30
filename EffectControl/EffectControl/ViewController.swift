//
//  ViewController.swift
//  EffectControl
//
//  Created by LJ on 15/7/29.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController,TransformControllerDelegate {

    @IBOutlet weak var toritorIV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var transformVC = segue.destinationViewController as! TransformController
        transformVC.delegate = self
        transformVC.currentTranform = toritorIV.transform
    }
    func tranfromDidChange(tranform: CGAffineTransform, sender: AnyObject) {
        toritorIV.transform = tranform
    }
}

