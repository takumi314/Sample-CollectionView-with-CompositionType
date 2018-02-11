//
//  PinterestiveAnimationController.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/09.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

let PINTERESTIVE_ANIMATION_DURATION = 0.7

class PinterestiveAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    let image: UIImage
    let imageSize: CGSize
    let imagePosition: CGPoint
    let imageURL: URL
    let cell: ImageLogCollectionViewCell

    var isPresent: Bool

    init(image: UIImage, size: CGSize, position: CGPoint, url :URL, cell: ImageLogCollectionViewCell, isPresent: Bool) {
        self.image = image
        self.imageSize = size
        self.imagePosition = position
        self.imageURL = url
        self.cell = cell
        self.isPresent = isPresent
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return PINTERESTIVE_ANIMATION_DURATION
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let _ = transitionContext.viewController(forKey: .from) else {
            transitionContext.cancelInteractiveTransition()
            return
        }
        guard let toVC = transitionContext.viewController(forKey: .to) as? ImageDetailViewController else {
            transitionContext.cancelInteractiveTransition()
            return
        }
        let containerView = transitionContext.containerView

        guard let image = cell.imageLog?.image else {
            transitionContext.cancelInteractiveTransition()
            return
        }

        let animatingView = UIImageView(image: image)
        animatingView.frame = CGRect(x: imagePosition.x,
                                     y: imagePosition.y,
                                     width: cell.frame.size.width,
                                     height: cell.frame.size.width)
        animatingView.contentMode = .scaleAspectFill
        animatingView.clipsToBounds = true
        cell.isHidden = true

        // set up ViewControoller state after transition
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.view.alpha = 0.0
        toVC.imageView.image = cell.imageLog?.imageData.image
        toVC.imageView.contentMode = .scaleAspectFill
        toVC.imageView.clipsToBounds = true
        toVC.imageView.isHidden = true
        toVC.modalView.isHidden = true
        toVC.modalView.isOpaque = true
        toVC.button.isHidden = true
        print(toVC.imageView.debugDescription)

        containerView.addSubview(toVC.view)
        containerView.addSubview(animatingView)

        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: duration,
            animations: {
                toVC.view.alpha = 1.0
                toVC.modalView.isOpaque = false

                let size = UIScreen.main.bounds
                var width = size.width - 32
                var height = width * 3 * 0.25
                var x: CGFloat = (size.width - width) * 0.5
                var y = (toVC.view.frame.height - 60 - height) * 0.5
                if size.width > size.height {
                    height = size.height - 50
                    width = height * 4 / 3
                    y = (size.height - height) * 0.5
                    x = (size.width - width) * 0.5
                }
                animatingView.frame = CGRect(x: x, y: y, width: width, height: height)
                print(animatingView.frame)
                print(toVC.imageView.debugDescription)
        },
            completion: { [unowned self](isCompleted: Bool) in
                toVC.view.isHidden = false
                toVC.modalView.isHidden = false
                toVC.imageView.isHidden = false
                toVC.button.isHidden = false

                print(toVC.imageView.debugDescription)

                self.cell.isHidden = false
                self.cell.imageView.isHidden = false
                animatingView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })

    }

}

extension PinterestiveAnimationController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return nil
    }

}
