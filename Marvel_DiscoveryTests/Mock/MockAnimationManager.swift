//
//  MockAnimationManager.swift
//  Marvel_DiscoveryTests
//
//  Created by eng-oday on 03/01/2024.
//

import Foundation
import UIKit

@testable import Marvel_Discovery
import XCTest

class MockAnimationManager:AnimationManager {
    
    var applyAnimationCalled = false
    var animateCalled = false
    var hideLogoWithAnimationCalled = false
    
    func applyAnimation(_ view: UIView, _ logoImage: UIImageView, completion: @escaping () -> Void) {
        applyAnimationCalled = true
        completion()
    }
    
    func animate(_ view: UIView, _ logoImage: UIImageView, completion: @escaping () -> Void) {
        animateCalled = true
        completion()
    }
    
    func hideLogoWithAnimation(_ logoImage: UIImageView, completion: @escaping () -> Void) {
        hideLogoWithAnimationCalled = true
        completion()
    }
    
    
}
