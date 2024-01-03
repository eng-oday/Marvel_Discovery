//
//  SplashViewModel.swift
//  Marvel_Discovery
//
//  Created by eng-oday on 03/01/2024.
//

import Foundation
import RxSwift


class SplashScreenViewModel {
    
    let disposeBag                  = DisposeBag()
    let viewDidAppear               = PublishSubject<Void>()
    let applyLogoAnimationTrigger   = PublishSubject<Void>()
    let goToHomeSubject                    = PublishSubject<Void>()
    

    init (){
        setupBinding()
    }
    
    private func setupBinding(){
        viewDidAppear.subscribe { _ in
            self.applyLogoAnimationTrigger.onNext(())
        }.disposed(by: disposeBag)
        
//        goToHomeSubject.subscribe { _ in
//            self.goToHome()
//        }.disposed(by: disposeBag)
        
    }
    
//    private func goToHome(){
//        let home = HomeViewController()
//        home.modalPresentationStyle = .overFullScreen
//        self.present(home, animated: true)
//    }
    
}
