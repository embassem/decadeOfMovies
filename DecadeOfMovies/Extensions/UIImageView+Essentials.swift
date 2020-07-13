//
//  UIImageView.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func flipImage() {
        let image = self.image
        let flipedImage = image?.imageFlippedForRightToLeftLayoutDirection()
        self.image = flipedImage
    }

    func startShimmering() {
        self.startShimmeringAnimation()
    }
    
    func stopShimmering() {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    
    func setImageWith(urlString: String?, placeholder: UIImage? = nil ) {
        self.image = placeholder
        guard let imageurl = urlString ,
            let url = URL(string: imageurl)
            else { return }
        var delay = 0.0
        if KingfisherManager.shared.cache.isCached(forKey: url.absoluteString) == false {
            self.startShimmeringAnimation()
            delay = Constants.imageDelayTime
        }
        self.backgroundColor = UIColor.grayscale200
        //TODO: remove this DispatchQueue After as it for demo delay purpose only.
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.kf.setImage(with: url) {[weak self] (_) in
                self?.stopShimmeringAnimation()
                self?.backgroundColor = UIColor.background
            }

        }

    }
}

fileprivate extension UIView {

    // ->1
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
    }

    func startShimmeringAnimation(animationSpeed: Float = 1.4,
                                  direction: Direction = .leftToRight,
                                  repeatCount: Float = MAXFLOAT) {

        // Create color  ->2
        let lightColor = UIColor.clear.cgColor
        //UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
        let blackColor = UIColor.grayscale800.cgColor

        // Create a CAGradientLayer  ->3
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [blackColor, lightColor, blackColor]
        gradientLayer.frame = CGRect(
            x: -self.bounds.size.width,
            y: -self.bounds.size.height,
            width: 3 * self.bounds.size.width,
            height: 3 * self.bounds.size.height)

        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)

        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }

        gradientLayer.locations =  [0.35, 0.50, 0.65] //[0.4, 0.6]
        self.layer.addSublayer(gradientLayer) //= gradientLayer

        // Add animation over gradient Layer  ->4
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.7, 0.9, 1.1]
        animation.duration = CFTimeInterval(animationSpeed)
        animation.repeatCount = repeatCount
        CATransaction.setCompletionBlock { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.layer.mask = nil
        }
        gradientLayer.add(animation, forKey: "shimmerAnimation")
        CATransaction.commit()
    }

    func stopShimmeringAnimation() {
        self.layer.mask = nil
    }

}
