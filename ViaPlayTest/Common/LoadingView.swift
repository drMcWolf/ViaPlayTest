import UIKit

class LoadingView: UIView {
    private struct Constants {
        static let animationKey: String = "backgroundColorAnimation"
        static let animationDuration: TimeInterval = 1
        static let backgroundAnimationKeyPath: String = "backgroundColor"
    }

    // MARK: - UIView

    override public init(frame: CGRect = .zero) {
        super.init(frame: frame)
        startAnimation()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        startAnimation()
    }

    // MARK: - Public Methods

    public func startAnimation() {
        stopAnimation()
        let animation = CABasicAnimation(keyPath: Constants.backgroundAnimationKeyPath)
        animation.fromValue = UIColor.gray.cgColor
        animation.toValue = UIColor.lightGray.cgColor
        animation.duration = Constants.animationDuration
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false

        layer.add(animation, forKey: Constants.animationKey)
    }

    public func stopAnimation() {
        layer.removeAnimation(forKey: Constants.animationKey)
    }

}
