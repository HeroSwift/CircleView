//
//  ViewController.swift
//  Example
//
//  Created by zhujl on 2018/8/15.
//  Copyright © 2018年 finstao. All rights reserved.
//

import UIKit

import CircleView

class ViewController: UIViewController {
    
    var circleView = CircleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleView.delegate = self
        
        circleView.ringWidth = 4
        circleView.trackWidth = 2
        circleView.trackOffset = 2
        circleView.trackValue = 0.3
        
        circleView.centerImage = UIImage(named: "preview")
        
        circleView.frame = CGRect(x: 150, y: 150, width: 0, height: 0)
        circleView.show(in: view)

        view.backgroundColor = UIColor.gray
    }
    
}

extension ViewController: CircleViewDelegate {
    
    func circleViewDidTouchDown(_ circleView: CircleView) {
        print("touch down")
        circleView.centerColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        circleView.centerImage = UIImage(named: "delete")
        circleView.setNeedsDisplay()
    }
    
    func circleViewDidTouchUp(_ circleView: CircleView, _ inside: Bool) {
        print("touch up, inside: \(inside)")
        circleView.centerColor = UIColor.white
        circleView.centerImage = UIImage(named: "preview")
        circleView.setNeedsDisplay()
    }
    
    func circleViewDidTouchEnter(_ circleView: CircleView) {
        print("touch enter")
        circleView.centerColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        circleView.setNeedsDisplay()
    }
    
    func circleViewDidTouchLeave(_ circleView: CircleView) {
        print("touch leave")
        circleView.centerColor = UIColor.white
        circleView.setNeedsDisplay()
    }
}

