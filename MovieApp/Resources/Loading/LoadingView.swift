//
//  LoadingView.swift
//  MovieApp
//
//  Created by Can Kalender on 18.08.2020.
//  Copyright © 2020 Can Kalender. All rights reserved.
//

import UIKit
import Lottie

open class LoadingView {
    
    public static var animationView = AnimationView(name: "8771-loading")
    
    public static func start(view: UIView) {
        
        animationView.backgroundBehavior = .pause
        animationView.loopMode = .loop
        let window = UIApplication.shared.keyWindow
        
        animationView.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        animationView.center = window!.center
        animationView.contentMode = .scaleAspectFit
        
        animationView.play()
        view.isUserInteractionEnabled = false
        window!.addSubview(animationView)
        UIApplication.shared.beginIgnoringInteractionEvents()
        
    }
    
    public static func stop(view: UIView) {
        animationView.stop()
        view.isUserInteractionEnabled = true
        animationView.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
