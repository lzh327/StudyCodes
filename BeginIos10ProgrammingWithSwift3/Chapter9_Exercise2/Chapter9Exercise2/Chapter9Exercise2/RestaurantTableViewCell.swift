//
//  RestaurantTableViewCell.swift
//  Chapter9Exercise2
//
//  Created by lizhen on 2016/11/30.
//  Copyright © 2016年 lizhen. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellSet(name: [String], location: [String], type: [String], thumbnail: [String], index: Int) {
        self.nameLabel.text = name[index]
        self.locationLabel.text = location[index]
        self.typeLabel.text = type[index]
        self.thumbnailImage.image = UIImage(named: thumbnail[index])
    }

}
