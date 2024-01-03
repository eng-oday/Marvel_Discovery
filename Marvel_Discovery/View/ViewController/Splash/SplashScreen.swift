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
    let splashViewModel = SplashScreenViewModel()
    let disposeBag      = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        splashViewModel.viewDidAppear.onNext(())
    }
    
    
    private func setupInitialState(){
        logoImage.alpha = 0
    }
    
    
    private func bindViewModel() {
         splashViewModel.applyLogoAnimationTrigger
             .subscribe(onNext: { [weak self] in
                 self?.applyAnimation()
             })
             .disposed(by: disposeBag)

        splashViewModel.goToHomeSubject
             .subscribe(onNext: { [weak self] in
                 self?.goToHome()
             })
             .disposed(by: disposeBag)
     }
    
    private func applyAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            guard let self else {return}
            self.animate()
        })
    }
    
    
    private func animate(){
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self else {return}
            let size = self.view.frame.size.width * 1.5
            self.logoImage.alpha = 1
            self.logoImage.frame = CGRect(x: 0, y: 0, width: size, height: size)
        } completion: { [weak self] completed in
            guard let self else {return}
            if completed {
                self.hideLogoWithAnimation()
            }
        }
    }
    
    private func hideLogoWithAnimation(){
        UIView.animate(withDuration: 1.5) { [weak self] in
            guard let self else {return}
            self.logoImage.alpha = 0
        }completion: { [weak self] completed in
            guard let self else {return}
            self.splashViewModel.goToHomeSubject.onNext(())
        }
    }
    
    private func goToHome(){
        let home = HomeViewController()
        home.modalPresentationStyle = .overFullScreen
        self.present(home, animated: true)
    }
    
    
}
