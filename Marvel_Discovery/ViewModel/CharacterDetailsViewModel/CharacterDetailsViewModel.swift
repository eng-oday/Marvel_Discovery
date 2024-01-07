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

    let data:BehaviorRelay = BehaviorRelay<Results?>(value: nil)

    init(data: Results?) {
        self.data.accept(data)
    }
    
}
