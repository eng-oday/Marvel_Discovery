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
    func getMarvelCharacters(currentPage:Int)
    func laodImageFromURL(with index:Int)
}

class HomeViewModel:HomeViewModelProtocol {
    private var networkService:NetworkService!
    private var loadImage:ImageLoaderActions!
    
    private var currentPage  = BehaviorRelay(value: 1)

    
    
    let characters:BehaviorRelay<[Results]>         = BehaviorRelay(value: [])
    let loadedImage:PublishRelay<(Int,UIImage?)>    = PublishRelay()
    let scrollEnded                                 = PublishRelay<Void>()
    let disposeBag                                  = DisposeBag()

    
    init(networkService: NetworkService! , loadImage:ImageLoaderActions) {
        self.networkService = networkService
        self.loadImage      = loadImage
    }
    
    func getMarvelCharacters(currentPage:Int) {
        networkService.request(MarvelEndpoint.getMarvelCharacters(limit: 10))
            .subscribe(onSuccess: { [weak self] (model:MarvelBase) in
                guard let marvelData = model.data?.results else {return}
                self?.characters.accept(marvelData)
            }, onFailure: { error in
                print(error)
            })
        
    }
    
    func laodImageFromURL(with index:Int){
        let urlPath         = characters.value[index].thumbnail?.path
        let imageExtension  = characters.value[index].thumbnail?.extension
        let imageUrl        = "\(urlPath ?? "").\(imageExtension ?? "")"

        loadImage.loadRemoteImageFrom(urlString: imageUrl).subscribe { [weak self] uiimage in
            self?.loadedImage.accept((index,uiimage))
        } onFailure: { error in
            print(error)
        }
    }

}



