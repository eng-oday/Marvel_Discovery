//
//  HomeViewController.swift
//  Marvel_Discovery
//
//  Created by eng-oday on 03/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    @IBOutlet weak var navigationBarContainerView: UIView!
    @IBOutlet weak var marvelLogoImage: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mainBodyContainerView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    
    private let homeViewModel     = HomeViewModel(networkService:BasicNetworkService(),loadImage:ImageLoader())
    private let disposeBag        = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        homeViewModel.getMarvelCharacters(currentPage: 1)
        bindTableView_SetCharacters()
        subscribeOnLoadedImageAndSetImageCells()
        bindTableView_CellDidSelected()
        //pagination()
    }
    
    private func setupTableView(){
        mainTableView.rx.setDelegate(self).disposed(by: disposeBag)
        mainTableView.register(UINib(nibName: TableViewCells.HomeMainTableViewCell, bundle: nil), forCellReuseIdentifier: TableViewCells.HomeMainTableViewCell)
    }
    
    @IBAction func searchButtonPRessed(_ sender: Any) {
    }
    
}


//MARK: - TABLE VIEW
extension HomeViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    private func bindTableView_SetCharacters(){
        homeViewModel.characters.bind(to: mainTableView.rx.items(cellIdentifier: TableViewCells.HomeMainTableViewCell)) { [weak self] index,model,cell in
            guard let cell = cell as? HomeMainTableViewCell else {return}
            cell.tittleLabel.text = model.name ?? ""
            self?.homeViewModel.laodImageFromURL(with: index)
            
        }.disposed(by: disposeBag)
    }
    
    private func subscribeOnLoadedImageAndSetImageCells() {
        homeViewModel.loadedImage
            .filter { $0.1 != nil}
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] index , image in
                guard let cell = self?.mainTableView.cellForRow(at: IndexPath(item: index, section: 0)) as? HomeMainTableViewCell else {return}
                cell.mainBackGroundImage.image = image
            } onError: { error in
                print("Error loading remote image: \(error)")
            }.disposed(by: disposeBag)
    }
    
    private func bindTableView_CellDidSelected(){
        mainTableView.rx.modelSelected(Results.self).subscribe(onNext: { item in
            print("SelectedItem: \(item.name ?? "")")
        }).disposed(by: disposeBag)
    }
    
}
