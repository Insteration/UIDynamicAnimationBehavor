//
//  ViewController.swift
//  UIDynamicAnimationBehavor
//
//  Created by Art Karma on 4/22/19.
//  Copyright © 2019 Art Karma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var animator: UIDynamicAnimator!
    private var snapping: UISnapBehavior! // panoramic tapped gesture
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: self.view) // это будет происходит во вьюхе
        snapping = UISnapBehavior(item: imageView, snapTo: self.view.center)
        snapping.damping = 0

        animator.addBehavior(snapping)
        
        
        let punGesture = UIPanGestureRecognizer(target: self, action: #selector(punAddView))
        imageView.addGestureRecognizer(punGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func punAddView(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animator.removeBehavior(snapping)
        case .changed:
            let translation = recognizer.translation(in: self.view)
            imageView.center = CGPoint(x: imageView.center.x + translation.x, y: imageView.center.y + translation.y) // take x coordinate and take to move
        case .possible:
            break
        case .ended, .failed, .cancelled:
            animator.addBehavior(snapping) // когда закончен жест или помломалось, то добавляется анимация
        @unknown default:
            fatalError()
        }
    }
    
    //    @objc func punAddView(recognizer: UIPanGestureRecognizer) {
    //        switch recognizer.state {
    //        case .changed:
    //            let translation = recognizer.translation(in: self.view)
    //            imageView.center = CGPoint(x: imageView.center.x + translation.x, y: imageView.center.y + translation.y) // take x coordinate and take to move
    ////            imageView.center = CGPoint(x: imageView.center.x + translation.x, y: imageView.center.y) // take x coordinate and take to move
    //            recognizer.setTranslation(.zero, in: self.view)
    //
    //
    //        default:
    //            ()
    //        }
    //    }
    
}

