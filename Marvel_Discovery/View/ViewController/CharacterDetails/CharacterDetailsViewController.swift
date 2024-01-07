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
        subscribeOnCharacterDetails()
    }
        
    func subscribeOnCharacterDetails() {
        characterViewModel?.data.subscribe(onNext: { [weak self] result in
            guard let self else {return}
            self.descriptionTextLabel.text      = result?.description ?? ""
            self.nameTextLabel.text             = result?.name ?? ""
        })

    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
    }

}

