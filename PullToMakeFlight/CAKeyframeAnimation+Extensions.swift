//
//  Created by Anastasiya Gorban on 4/20/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//
//  Licensed under the MIT license: http://opensource.org/licenses/MIT
//  Latest version can be found at https://github.com/Yalantis/PullToMakeFlight
//

import CoreGraphics

enum AnimationType: String {
    
    case rotation = "transform.rotation.z"
    case opacity = "opacity"
    case translationX = "transform.translation.x"
    case translationY = "transform.translation.y"
    case position = "position"
    case positionY = "position.y"
    case scaleX = "transform.scale.x"
    case scaleY = "transform.scale.y"
}

enum TimingFunction {
    
    case linear, easeIn, easeOut, easeInEaseOut
}

func mediaTimingFunction(_ function: TimingFunction) -> CAMediaTimingFunction {
    switch function {
    case .linear: return CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    case .easeIn: return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
    case .easeOut: return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    case .easeInEaseOut: return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    }
}

extension CAKeyframeAnimation {
    
    class func animation(for type: AnimationType, values: [Any], keyTimes: [Double], duration: Double, beginTime: Double, timingFunctions: [TimingFunction] = [TimingFunction.linear]) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: type.rawValue)
        animation.values = values
        animation.keyTimes = keyTimes as [NSNumber]?
        animation.duration = duration
        animation.beginTime = beginTime
        animation.timingFunctions = timingFunctions.map { timingFunction in
            return mediaTimingFunction(timingFunction)
        }
            
        return animation
    }
    
    class func animationPosition(_ path: CGPath, duration: Double, timingFunction: TimingFunction, beginTime: Double) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path
        animation.duration = duration
        animation.beginTime = beginTime
        animation.timingFunction = mediaTimingFunction(timingFunction)
        return animation
    }
}

extension UIView {
    
    func addAnimation(_ animation: CAKeyframeAnimation) {
        layer.add(animation, forKey: description + animation.keyPath!)
        layer.speed = 0
    }
    
    func removeAllAnimations() {
        layer.removeAllAnimations()
    }
}
