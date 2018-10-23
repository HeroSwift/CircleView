
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
        
        circleView.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        circleView.sizeToFit()
        view.addSubview(circleView)

        view.backgroundColor = UIColor.gray
    }
    
}

extension ViewController: CircleViewDelegate {
    
    func circleViewDidTouchDown(_ circleView: CircleView) {
        print("touch down")
        circleView.ringWidth = 20
        circleView.ringColor = UIColor.red
        circleView.centerRadius = 50
        circleView.centerColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        circleView.centerImage = UIImage(named: "delete")
        circleView.sizeToFit()
        circleView.setNeedsDisplay()
    }
    
    func circleViewDidTouchUp(_ circleView: CircleView, _ inside: Bool) {
        print("touch up, inside: \(inside)")
        circleView.ringWidth = 4
        circleView.ringColor = UIColor.red
        circleView.centerRadius = 30
        circleView.centerColor = UIColor.white
        circleView.centerImage = UIImage(named: "preview")
        circleView.sizeToFit()
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

