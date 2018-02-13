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

    let imagePosition: CGPoint
    let cell: ImageLogCollectionViewCell

    var isPresent: Bool

    init(position: CGPoint, cell: ImageLogCollectionViewCell, isPresent: Bool) {
        self.imagePosition = position
        self.cell = cell
        self.isPresent = isPresent
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return PINTERESTIVE_ANIMATION_DURATION
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            presentTransition(transitionContext: transitionContext)
        } else {
            dissmissalTransition(transitionContext: transitionContext)
        }
    }

    func presentTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let secondVC = transitionContext.viewController(forKey: .to) as? ImageDetailViewController else {
            transitionContext.cancelInteractiveTransition()
            return
        }
        let containerView = transitionContext.containerView

        guard let image = cell.imageLog?.image else {
            transitionContext.cancelInteractiveTransition()
            return
        }

        let animatingView = UIImageView(image: image)
        if isPresent {
            animatingView.frame = CGRect(x: imagePosition.x,
                                         y: imagePosition.y,
                                         width: cell.frame.size.width,
                                         height: cell.frame.size.width)
            animatingView.contentMode = .scaleAspectFill
            animatingView.clipsToBounds = true
            cell.isHidden = true
        } else {
            animatingView.frame = secondVC.imageView.frame
        }

        // set up ViewControoller state after transition
        secondVC.view.frame = transitionContext.finalFrame(for: secondVC)
        secondVC.view.alpha = 0.0
        secondVC.imageView.image = cell.imageLog?.imageData.image
        secondVC.imageView.contentMode = .scaleAspectFill
        secondVC.imageView.clipsToBounds = true
        secondVC.imageView.isHidden = true
        secondVC.modalView.isHidden = true
        secondVC.button.isHidden = true
        print(secondVC.imageView.debugDescription)

        containerView.addSubview(secondVC.view)
        containerView.addSubview(animatingView)

        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: duration,
            animations: {
                secondVC.view.alpha = 1.0

                let size = UIScreen.main.bounds
                var width = size.width - 32
                var height = width * 3 * 0.25
                var x = (size.width - width) * 0.5
                var y = (secondVC.view.frame.height - 60 - height) * 0.5
                if size.width > size.height {
                    height = size.height - 50
                    width = height * 4 / 3
                    y = (size.height - height) * 0.5
                    x = (size.width - width) * 0.5
                }

                animatingView.frame = CGRect(x: x, y: y, width: width, height: height)
                print(animatingView.frame)
                print(secondVC.imageView.debugDescription)
        },
            completion: { [unowned self](isCompleted: Bool) in
                secondVC.view.isHidden = false
                secondVC.modalView.isHidden = false
                secondVC.imageView.isHidden = false
                secondVC.button.isHidden = false

                print(secondVC.imageView.debugDescription)

                self.cell.isHidden = false
                self.cell.imageView.isHidden = false
                animatingView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })

    }

    func  dissmissalTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let firstVC = transitionContext.viewController(forKey: .from) else {
            transitionContext.cancelInteractiveTransition()
            return
        }
        guard let secondVC = transitionContext.viewController(forKey: .to) as? ImageDetailViewController else {
            transitionContext.cancelInteractiveTransition()
            return
        }
        let containerView = transitionContext.containerView

        guard let image = cell.imageLog?.image else {
            transitionContext.cancelInteractiveTransition()
            return
        }

        guard let animatingView = secondVC.imageView.snapshotView(afterScreenUpdates: false) else {
            transitionContext.completeTransition(true)
            return
        }
        animatingView.frame = containerView.convert(secondVC.imageView.frame, from: secondVC.imageView.superview!)

        secondVC.view.isHidden = true

        cell.imageView.isHidden = true

        firstVC.view.frame = transitionContext.finalFrame(for: firstVC)

        containerView.insertSubview(firstVC.view, belowSubview: secondVC.view)
        containerView.addSubview(animatingView)

        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: duration,
            animations: {
                secondVC.view.alpha = 0
                secondVC.modalView.isOpaque = false

                let x = self.imagePosition.x
                let y = self.imagePosition.y
                let width = self.cell.frame.size.width
                let height = self.cell.frame.size.height

                animatingView.frame = CGRect(x: x, y: y, width: width, height: height)
                print(animatingView.frame)
                print(secondVC.imageView.debugDescription)
        },
            completion: { [unowned self](isCompleted: Bool) in
                secondVC.view.isHidden = false
                secondVC.modalView.isHidden = false
                secondVC.imageView.isHidden = false
                secondVC.button.isHidden = false

                print(secondVC.imageView.debugDescription)

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
