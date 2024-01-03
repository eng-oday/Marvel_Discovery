//
//  SplashViewModelTests.swift
//  Marvel_DiscoveryTests
//
//  Created by eng-oday on 04/01/2024.
//

import XCTest
@testable import Marvel_Discovery
final class SplashViewModelTests: XCTestCase {

    var sut:SplashViewModel!
    var mockAnimationManager:MockAnimationManager!


    override func setUp() {
        mockAnimationManager    = MockAnimationManager()
        sut                     = SplashViewModel(animationManager: mockAnimationManager)
    }

    override func tearDown() {
        mockAnimationManager    = nil
        sut                     = nil
    }


    func testSplashViewModel_ItwillApplyTheAnimation_MustAllFunctionHasCalled(){
        //ARRANGE
        let view        = UIView()
        let image       = UIImageView()
        // ACT
        sut.startAnimation(view: view, logoImage: image)
        // ASSERT
        XCTAssertTrue(mockAnimationManager.applyAnimationCalled)
        XCTAssertTrue(mockAnimationManager.animateCalled)
        XCTAssertTrue(mockAnimationManager.hideLogoWithAnimationCalled)
    }


}
