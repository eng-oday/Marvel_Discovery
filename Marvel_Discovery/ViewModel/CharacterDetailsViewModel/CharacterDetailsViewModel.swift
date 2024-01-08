//
//  CharacterDetailsViewModel.swift
//  Marvel_Discovery
//
//  Created by eng-oday on 07/01/2024.
//

import Foundation
import RxSwift
import RxCocoa


class CharacterDetailsViewModel {

    private var loadImage:ImageLoaderActions?

    
    let characterData:BehaviorRelay = BehaviorRelay<Results?>(value: nil)
    let characterImage:BehaviorRelay = BehaviorRelay<UIImage?>(value: nil)

    init(characterData: Results? , loadImage:ImageLoaderActions?) {
        self.characterData.accept(characterData)
        self.loadImage = loadImage
        laodImageFromURL()
    }
    
    func laodImageFromURL(){
        let urlPath         = characterData.value?.thumbnail?.path
        let imageExtension  = characterData.value?.thumbnail?.extension
        let imageUrl        = "\(urlPath ?? "").\(imageExtension ?? "")"
        loadImage?.loadRemoteImageFrom(urlString: imageUrl).subscribe { [weak self] uiimage in
            self?.characterImage.accept(uiimage)
        } onFailure: { error in
            print(error)
        }
    }

}
