//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by lizhen on 2016/11/30.
//  Copyright © 2016年 LiZhen. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellSet(name: String, location: String, type: String, thumbnail: String) {
        self.nameLabel.text = name
        self.locationLabel.text = location
        self.typeLabel.text = type
        self.thumbnailImageView.image = UIImage(named: thumbnail)
    }

}
