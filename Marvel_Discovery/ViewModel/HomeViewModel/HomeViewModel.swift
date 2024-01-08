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
    func getMarvelCharacters(offsetElments:Int)
    func laodImageFromURL(with index:Int)
}

class HomeViewModel:HomeViewModelProtocol {
    private var networkService:NetworkService!
    private var loadImage:ImageLoaderActions!
        
    private var offsetElments = 0
    
    let characters:BehaviorRelay<[Results]>         = BehaviorRelay(value: [])
    let loadedImage:PublishRelay<(Int,UIImage?)>  = PublishRelay()
    let scrollEnded                                 = PublishRelay<Void>()
    let disposeBag                                  = DisposeBag()

    
    var detailsViewModel                            = CharacterDetailsViewModel(characterData: nil, loadImage: nil)
    let selectedItem                                =  PublishSubject<Any>()
    
    init(networkService: NetworkService! , loadImage:ImageLoaderActions) {
        self.networkService = networkService
        self.loadImage      = loadImage
        getMarvelCharWithPagination()
    }
    
    func getMarvelCharacters(offsetElments:Int = 0) {
        networkService.request(MarvelEndpoint.getMarvelCharacters(limit: 10, offset: offsetElments))
            .subscribe(onSuccess: { [weak self] (model:MarvelBase) in
                guard let marvelData = model.data?.results else {return}
                self?.characters.accept((self?.characters.value ?? []) + marvelData)
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
    
    private func getMarvelCharWithPagination(){
        scrollEnded.subscribe {[weak self] _ in
            guard let self else {return}
            self.offsetElments += 10
            self.getMarvelCharacters(offsetElments: self.offsetElments)
        }
    }
    
    func didSelectItemAt(index:Int){
        let selectedItemData = characters.value[index]
        var characterImage:UIImage?
        detailsViewModel = CharacterDetailsViewModel(characterData: selectedItemData, loadImage: loadImage)
        selectedItem.onNext(())
    }


}



