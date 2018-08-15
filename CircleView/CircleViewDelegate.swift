
public protocol CircleViewDelegate {

    func circleViewDidTouchDown(_ circleView: CircleView)

    func circleViewDidTouchUp(_ circleView: CircleView, _ inside: Bool)

    func circleViewDidTouchEnter(_ circleView: CircleView)

    func circleViewDidTouchLeave(_ circleView: CircleView)

}

extension CircleViewDelegate {

    func circleViewDidTouchDown(_ circleView: CircleView) { }

    func circleViewDidTouchUp(_ circleView: CircleView, _ inside: Bool) { }

    func circleViewDidTouchEnter(_ circleView: CircleView) { }

    func circleViewDidTouchLeave(_ circleView: CircleView) { }

}
