//
//  HomeMainTableViewCell.swift
//  Marvel_Discovery
//
//  Created by 3rabApp-oday on 04/01/2024.
//

import UIKit

class HomeMainTableViewCell: UITableViewCell {

    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var mainBackGroundImage: UIImageView!
    @IBOutlet weak var tittleBackGroundImage: UIImageView!
    @IBOutlet weak var tittleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
