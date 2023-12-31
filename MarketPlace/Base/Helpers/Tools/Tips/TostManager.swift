//
//  TostManager.swift
//  MarketPlace
//
//  Created by tanktank on 2022/4/28.
//

import UIKit

final class TostManager: NSObject, UIViewControllerTransitioningDelegate {
    private let loaf: Loaf
    private let size: CGSize
    var animator: TipsAnimator
    
    init(loaf: Loaf, size: CGSize) {
        self.loaf = loaf
        self.size = size
        self.animator = TipsAnimator(duration: 0.4, loaf: loaf, size: size)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return TostController(
            presentedViewController: presented,
            presenting: presenting,
            loaf: loaf,
            size: size
        )
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = false
        return animator
    }
}

