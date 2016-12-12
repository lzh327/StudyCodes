//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by LiZhen on 2016/12/9.
//  Copyright © 2016年 LiZhen. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        self.restaurantImageView.image = UIImage(named: self.restaurant.image)
        self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        // Display the restaurant name in the navigation bar
        self.title = restaurant.name
        
        //viewDidLoad method only run one time
        //navigationController?.hidesBarsOnSwipe = false
    }
    
    //viewWillAppear method would be called every time the view will appear
    //Unhide the navigation bar on swipe and show it
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantDetailTableViewCell
        
        //Configure the cell
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = self.restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = self.restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = self.restaurant.location
        case 3:
            cell.fieldLabel.text = "Phone"
            cell.valueLabel.text = self.restaurant.phone
        case 4:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (self.restaurant.isVisited) ? "Yes, I have been here before" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
}
