//
//  HomeViewModel.swift
//  Marvel_Discovery
//
//  Created by eng-oday on 05/01/2024.
//

import Foundation
import RxSwift
import RxCocoa


protocol HomeViewModelProtocol {
    func getMarvelCharacters()
}

class HomeViewModel:HomeViewModelProtocol {
    var networkService:NetworkService!
    
    let characters:BehaviorRelay<[Results]> = BehaviorRelay(value: [])
    
    init(networkService: NetworkService!) {
        self.networkService = networkService
    }
    
    func getMarvelCharacters() {
        networkService.request(MarvelEndpoint.getMarvelCharacters(limit: 4))
            .subscribe(onSuccess: { [weak self] (model:MarvelBase) in
                guard let marvelData = model.data?.results else {return}
                self?.characters.accept(marvelData)
            }, onFailure: { error in
                print(error)
            })
        
    }
    
    
}



