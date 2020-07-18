//
//  UIColor+App.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit

// This Color wrapper added to support ios 10 , it's reflect the colors in Colors.xcassets

// swiftlint:disable all
extension UIColor {

    class var background: UIColor {
        if #available(iOS 11.0, *) {
            return Asset.Colors.background.color
        } else {
            return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }

    class var grayscale200: UIColor {
        if #available(iOS 11.0, *) {
            return Asset.Colors.grayscale200.color
        } else {
            return UIColor(red: 0.97, green: 0.98, blue: 0.98, alpha: 1.0)
        }
    }

    class var grayscale600: UIColor {
        if #available(iOS 11.0, *) {
            return Asset.Colors.grayscale600.color
        } else {
            return UIColor(red: 0.44, green: 0.53, blue: 0.59, alpha: 1.0)
        }
    }


    class var grayscale800: UIColor {
        if #available(iOS 11.0, *) {
            return Asset.Colors.grayscale800.color
        } else {
            return UIColor(red: 0.13, green: 0.18, blue: 0.20, alpha: 1.0)
        }
    }
    
    class var grayscale900: UIColor {
        if #available(iOS 11.0, *) {
            return Asset.Colors.grayscale900.color
        } else {
            return UIColor(red: 20/255, green: 32/255, blue: 38/255, alpha: 1.0)
        }
    }

}
