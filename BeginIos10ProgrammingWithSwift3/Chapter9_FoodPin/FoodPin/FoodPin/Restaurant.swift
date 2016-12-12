//
//  Restaurant.swift
//  FoodPin
//
//  Created by LiZhen on 2016/12/12.
//  Copyright © 2016年 LiZhen. All rights reserved.
//

import Foundation

class Restaurant {
    var name = ""
    var type = ""
    var location = ""
    var image = ""
    var isVisited = false
    
    init(name: String, type: String, location: String, image: String, isVisited: Bool = false) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
    }
}
