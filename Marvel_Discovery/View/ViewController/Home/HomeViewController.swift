//
//  HomeViewController.swift
//  Marvel_Discovery
//
//  Created by eng-oday on 03/01/2024.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var navigationBarContainerView: UIView!
    @IBOutlet weak var marvelLogoImage: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mainBodyContainerView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    private func setupTableView(){
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: TableViewCells.HomeMainTableViewCell, bundle: nil), forCellReuseIdentifier: TableViewCells.HomeMainTableViewCell)
    }

    @IBAction func searchButtonPRessed(_ sender: Any) {
    }

}



extension HomeViewController:UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCells.HomeMainTableViewCell, for: indexPath) as? HomeMainTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    
}
