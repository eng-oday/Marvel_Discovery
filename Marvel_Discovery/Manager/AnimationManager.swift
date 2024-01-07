//
//  AnimationManager.swift
//  Marvel_Discovery
//
//  Created by eng-oday on 03/01/2024.
//

import Foundation
import UIKit

protocol AnimationManager{
    func applyAnimation(_ view:UIView , _ logoImage:UIImageView , completion:@escaping () -> Void)
    func animate(_ view:UIView , _ logoImage:UIImageView,completion:@escaping () -> Void)
    func hideLogoWithAnimation(_ logoImage:UIImageView,completion:@escaping () -> Void)
}


final class DefaultAnimationManager:AnimationManager {
    
    
    func applyAnimation(_ view: UIView, _ logoImage: UIImageView, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            completion()
        })
    }
    
    func animate(_ view: UIView, _ logoImage: UIImageView, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 1) {
            let size = view.frame.size.width * 1.5
            logoImage.alpha = 1
            logoImage.frame = CGRect(x: 0, y: 0, width: size, height: size)
        } completion: {  _ in
                completion()
        }

    }
    
    func hideLogoWithAnimation(_ logoImage: UIImageView, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 1.5) {
            logoImage.alpha = 0
        }completion: { _ in
            completion()
        }
    }
    

}
