//
//  TipsAnimator.swift
//  MarketPlace
//
//  Created by tanktank on 2022/4/28.
//

import UIKit

final class TipsAnimator: NSObject {
    var presenting: Bool!
    private let loaf: Loaf
    private let duration: TimeInterval
    private let size: CGSize
    
    init(duration: TimeInterval, loaf: Loaf, size: CGSize) {
        self.duration = duration
        self.loaf = loaf
        self.size = size
        super.init()
    }
}

extension TipsAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key: UITransitionContextViewControllerKey = presenting ? .to : .from
        let controller = transitionContext.viewController(forKey: key)!
        
        if presenting {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        
        switch presenting ? loaf.presentingDirection : loaf.dismissingDirection {
        case .vertical:
            dismissedFrame.origin.y = (loaf.location == .bottom) ? controller.view.frame.height + 60 : -size.height - 60
        case .left:
            dismissedFrame.origin.x = -controller.view.frame.width * 2
        case .right:
            dismissedFrame.origin.x = controller.view.frame.width * 2
        }
        
        let initialFrame = presenting ? dismissedFrame : presentedFrame
        let finalFrame = presenting ? presentedFrame : dismissedFrame
        let animationOption: UIView.AnimationOptions = presenting ? .curveEaseOut : .curveEaseIn
        
        controller.view.alpha = presenting ? 0 : 1
        
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.65, options: animationOption, animations: {
            controller.view.frame = finalFrame
            controller.view.alpha = self.presenting ? 1 : 0
        }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }
    
}

