
import UIKit

public class CircleView: UIView {

    // 内圆
    public var centerRadius = CGFloat(36.0)
    public var centerColor = UIColor.white

    // 圆环
    public var ringWidth = CGFloat(7.0)
    public var ringColor = UIColor(red: 221.0 / 255.0, green: 221.0 / 255.0, blue: 221.0 / 255.0, alpha: 1.0)

    // 高亮轨道
    public var trackWidth = CGFloat(7.0)
    public var trackColor = UIColor(red: 80.0 / 255.0, green: 210.0 / 255.0, blue: 17.0 / 255.0, alpha: 1.0)
    
    // 轨道默认贴着圆环的外边，给正值可以往内部来点，当然负值就能出去点...
    public var trackOffset = CGFloat(0.0)
    
    // 轨道的值 0.0 - 1.0，影响轨道圆弧的大小
    public var trackValue = 0.0
    
    // 内圆支持放一张图片
    public var imageView: UIImageView?

    // 是否正在触摸
    private var isTouching = false

    // 是否触摸在圆内部
    private var isTouchInside = false

    // 半径 = 内圆 + 圆环
    private var radius: CGFloat {
        return centerRadius + ringWidth
    }

    public var delegate: CircleViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
    }

    public func show(in view: UIView) {
        sizeToFit()
        view.addSubview(self)
    }
    
    public func setImage(image: UIImage) {
        imageView = UIImageView(image: image)
        imageView!.layer.masksToBounds = true
        addSubview(imageView!)
    }

    // 点是否在内圆中
    // 因为这个 View 的使用方式一般是把内圆作为可点击的按钮，周围的轨道作为状态指示
    private func isPointInside(_ x: CGFloat, _ y: CGFloat) -> Bool {
        let offsetX = x - frame.width / 2
        let offsetY = y - frame.height / 2
        let distance = sqrt(offsetX * offsetX + offsetY * offsetY)
        return distance <= centerRadius
    }

    // 按下
    private func touchDown() {
        isTouching = true
        isTouchInside = true
        delegate?.circleViewDidTouchDown(self)
    }

    // 松开，inside 表示是否在内圆松开
    private func touchUp(_ inside: Bool) {
        guard isTouching else {
            return
        }
        isTouching = false
        isTouchInside = false
        delegate?.circleViewDidTouchUp(self, inside)
    }

    public override func sizeToFit() {
        frame = CGRect(origin: frame.origin, size: CGSize(width: 2 * radius, height: 2 * radius))
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isTouching, touches.count == 1 else {
            return
        }
        if let point = touches.first?.location(in: self) {
            if isPointInside(point.x, point.y) {
                touchDown()
            }
        }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isTouching, touches.count == 1 else {
            return
        }
        if let point = touches.first?.location(in: self) {
            let inside = isPointInside(point.x, point.y)
            if inside != isTouchInside {
                isTouchInside = inside
                if isTouchInside {
                    delegate?.circleViewDidTouchEnter(self)
                }
                else {
                    delegate?.circleViewDidTouchLeave(self)
                }
            }
        }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchUp(isTouchInside)
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchUp(false)
    }

    public override func draw(_ rect: CGRect) {

        let currentContext = UIGraphicsGetCurrentContext()
        guard let context = currentContext else {
            return
        }

        let centerX = frame.width / 2
        let centerY = frame.height / 2

        // 画外圆
        if ringWidth > 0 {
            context.setFillColor(ringColor.cgColor)
            context.addEllipse(in: CGRect(x: centerX - radius, y: centerY - radius, width: 2 * radius, height: 2 * radius))
            context.fillPath()

            // 在上面画高亮圆弧
            if ringWidth >= trackWidth {
                context.setStrokeColor(trackColor.cgColor)
                context.setLineWidth(trackWidth)

                let startAngle = -0.5 * Double.pi
                let endAngle = 2 * Double.pi * trackValue + startAngle

                context.addArc(center: CGPoint(x: centerX, y: centerY), radius: radius - trackWidth * 0.5 - trackOffset, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: false)
                context.strokePath()
            }
        }

        // 画内圆
        context.setFillColor(centerColor.cgColor)
        context.addEllipse(in: CGRect(x: centerX - centerRadius, y: centerY - centerRadius, width: 2 * centerRadius, height: 2 * centerRadius))
        context.fillPath()

    }
    
    public override func layoutSubviews() {
        if let imageView = imageView {
            imageView.frame = CGRect(x: ringWidth, y: ringWidth, width: centerRadius * 2, height: centerRadius * 2)
            imageView.layer.cornerRadius = centerRadius
        }
    }

}