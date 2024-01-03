//
//  SplashScreen.swift
//  Marvel_Discovery
//
//  Created by eng-oday on 03/01/2024.
//

import UIKit
import RxSwift
import RxCocoa


class SplashScreen: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    
    //VIEW MODEL
    let splashViewModel = SplashViewModel(animationManager: DefaultAnimationManager())
    let disposeBag      = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        bindViewModel()
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        splashViewModel.applyLogoAnimationTrigger.onNext(())
    }
    
    
    private func setupInitialState(){
        logoImage.alpha = 0
    }
    
    
    private func bindViewModel() {
        splashViewModel.applyLogoAnimationTrigger
            .subscribe(onNext: { [weak self] in
                guard let self else {return}
                self.splashViewModel.startAnimation(view: view, logoImage: logoImage)
            })
            .disposed(by: disposeBag)
        
        splashViewModel.goToHomeSubject
            .subscribe(onNext: { [weak self] in
                self?.goToHome()
            })
            .disposed(by: disposeBag)
    }
    
    private func goToHome(){
        let home = HomeViewController()
        home.modalPresentationStyle = .overFullScreen
        self.present(home, animated: true)
    }
    
    
}
