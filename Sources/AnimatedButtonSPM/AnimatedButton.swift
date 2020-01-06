//
//  File.swift
//  
//
//  Created by Juliano Goncalves Alvarenga on 06/01/20.
//

import UIKit
import UIViewExtensionsSPM

/// This button subclass has Touch events mapped, its react sacling down when user touch
public class AnimatedButton: UIButton {
    
    var initialFrame: CGRect = {
          let c = CGRect()
          return c
    }()
      
    let activityIndicatorView: UIActivityIndicatorView = {
        let c = UIActivityIndicatorView()
        c.hidesWhenStopped = true
        c.style = .white
        return c
    }()
    
    public var bindableCompletedTouch = Bindable<Bool>()
    var scaleDownFactor: CGFloat = 0.9
    var scaleUpFactor: CGFloat = 1
    var springWithDamping: CGFloat = 0.8
    var springVelocity: CGFloat = 1
    var duration: TimeInterval = 0.3
    var delay: TimeInterval = 0
    
    public func setupAnimation(scaleDownFactor: CGFloat, scaleUpFactor: CGFloat, springWithDamping: CGFloat,
                               springVelocity: CGFloat, duration: TimeInterval, delay: TimeInterval) {
        self.scaleDownFactor = scaleDownFactor
        self.scaleUpFactor = scaleUpFactor
        self.springWithDamping = springWithDamping
        self.springVelocity = springVelocity
        self.duration = duration
        self.delay = delay
    }
      
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        addTarget(self, action: #selector(handleTouchDown), for: .touchDown)
        addTarget(self, action: #selector(handleTouchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(handleTouchDragExit), for: .touchDragExit)
        addTarget(self, action: #selector(handleTouchDragEnter), for: .touchDragEnter)
        addTarget(self, action: #selector(handleTouchCancel), for: .touchCancel)
        addSubview(activityIndicatorView)
    }
    
    //MARK: Touch events
    @objc func handleTouchDown()  {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: springWithDamping,
            initialSpringVelocity: springVelocity,
            options: .curveEaseOut,
            animations: {
                self.transform = CGAffineTransform(scaleX: self.scaleDownFactor, y: self.scaleDownFactor )
        })
    }

    @objc func handleTouchUpInside()  {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: springWithDamping,
            initialSpringVelocity: springVelocity,
            options: .curveEaseOut,
            animations: {
                self.transform = CGAffineTransform(scaleX: self.scaleDownFactor, y: self.scaleDownFactor )
        }) { (_) in
            UIView.animate(
                withDuration: self.duration,
                delay: self.delay,
                usingSpringWithDamping: self.springWithDamping,
                initialSpringVelocity: self.springVelocity,
                options: .curveEaseOut,
                animations: {
                    self.transform = CGAffineTransform(scaleX: self.scaleUpFactor, y: self.scaleUpFactor )
                    self.bindableCompletedTouch.value = true
            })
        }
    }
    
    @objc func handleTouchDragExit()  {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: springWithDamping,
            initialSpringVelocity: springVelocity,
            options: .curveEaseOut,
            animations: {
                self.transform = CGAffineTransform(scaleX: self.scaleUpFactor, y: self.scaleUpFactor )
        })
    }
    
    @objc func handleTouchDragEnter()  {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: springWithDamping,
            initialSpringVelocity: springVelocity,
            options: .curveEaseOut,
            animations: {
                self.transform = CGAffineTransform(scaleX: self.scaleDownFactor, y: self.scaleDownFactor )
        })
    }
    
    @objc func handleTouchCancel()  {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: springWithDamping,
            initialSpringVelocity: springVelocity,
            options: .curveEaseOut,
            animations: {
                self.transform = CGAffineTransform(scaleX: self.scaleUpFactor, y: self.scaleUpFactor )
        })
    }
}

//MARK: - Animate Spin
public extension AnimatedButton {
    
    func animateButtonActivity(hasActivity: Bool) {
        DispatchQueue.main.async {
            if self.bounds.width != self.bounds.height  {
                self.recordingInitialSize(for: self.bounds)
            }
            self.constraints.forEach({$0.isActive = false})
            self.titleLabel?.alpha = 0
            if hasActivity {
                self.centerInSuperview(size: .init(width: self.bounds.height, height: self.bounds.height))
                UIView.animate(
                    withDuration: self.duration,
                    delay: self.delay,
                    usingSpringWithDamping: self.springWithDamping,
                    initialSpringVelocity: self.springVelocity,
                    options: .curveEaseOut,
                    animations: {
                        self.layoutIfNeeded()
                        self.activityIndicatorView.centerInSuperview()
                    }, completion: { _ in
                        self.activityIndicatorView.startAnimating()
                })
            } else {
                let size = CGSize(width: self.initialFrame.width, height: self.initialFrame.height)
                self.centerInSuperview(size: size)
                UIView.animate(
                    withDuration: self.duration,
                    delay: self.delay,
                    usingSpringWithDamping: self.springWithDamping,
                    initialSpringVelocity: self.springVelocity,
                    options: .curveEaseOut,
                    animations: {
                        self.titleLabel?.alpha = 1
                        self.layoutIfNeeded()
                        self.activityIndicatorView.centerInSuperview()
                    }, completion: { _ in
                        self.activityIndicatorView.stopAnimating()
                })
            }
        }
    }
    
    fileprivate func recordingInitialSize(for frame: CGRect) {
        initialFrame = frame
    }
}
