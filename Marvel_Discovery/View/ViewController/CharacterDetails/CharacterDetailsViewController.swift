//
//  CharacterDetailsViewController.swift
//  Marvel_Discovery
//
//  Created by eng-oday on 07/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameTittleLabel: UILabel!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var descriptionTittleLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    
    var characterViewModel:CharacterDetailsViewModel?
    let disposeBag          = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainImage()
        subscribeOnCharacterDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    private func setupMainImage(){
        mainImageView.contentMode = .scaleAspectFill
    }
    
//    private func setupNavigationController(){
//        self.navigationController?.additionalSafeAreaInsets.top = -view.safeAreaInsets.top
//
//    }
    
        
    func subscribeOnCharacterDetails() {
        characterViewModel?.characterData.subscribe(onNext: { [weak self] result in
            guard let self else {return}
            self.descriptionTextLabel.text      = result?.description ?? ""
            self.nameTextLabel.text             = result?.name ?? ""
        }).disposed(by: disposeBag)
        
        characterViewModel?.characterImage.subscribe(onNext: {[weak self] image in
            self?.mainImageView.image = image
        }).disposed(by: disposeBag)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

