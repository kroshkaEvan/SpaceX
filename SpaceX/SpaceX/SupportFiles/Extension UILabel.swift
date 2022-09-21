//
//  Extension UILabel.swift
//  SpaceX
//
//  Created by Эван Крошкин on 21.09.22.
//

import UIKit

extension UILabel {
    func addCubeAnimation() {
        let animationTransition = CATransition()
        animationTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animationTransition.type = CATransitionType.push
        animationTransition.subtype = CATransitionSubtype.fromBottom
        animationTransition.duration = 0.4
        layer.add(animationTransition,
                  forKey: CATransitionType.push.rawValue)
    }
}

