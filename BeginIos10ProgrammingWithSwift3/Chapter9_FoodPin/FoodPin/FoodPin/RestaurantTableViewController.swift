//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by LiZhen on 2016/11/30.
//  Copyright © 2016年 LiZhen. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

//    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
//    
//    var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg", "cafeloisl.jpg", "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg", "bourkestreetbakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg", "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg", "fiveleaves.jpg", "cafelore.jpg", "confessional.jpg", "barrafina.jpg", "donostia.jpg", "royaloak.jpg", "caskpubkitchen.jpg"]
//    
//    var restaurantLocations = ["HongKong", "HongKong", "HongKong", "HongKong", "HongKong", "HongKong", "HongKong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
//    
//    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
//    
//    var restaurantIsVisited = Array(repeating: false, count: 21)
    
    var restaurants:[Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend.jpg"),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei.jpg"),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha.jpg"),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl.jpg"),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster.jpg"),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkeerestaurant.jpg"),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier.jpg"),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery.jpg"),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haighschocolate.jpg"),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palominoespresso.jpg"),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate.jpg"),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif.jpg"),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "grahamavenuemeats.jpg"),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "wafflewolf.jpg"),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves.jpg"),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore.jpg"),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional.jpg"),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina.jpg"),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia.jpg"),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak.jpg"),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "caskpubkitchen.jpg")
        ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell

        // Configure the cell...
//        cell.textLabel?.text = restaurantNames[indexPath.row]
//        cell.imageView?.image = UIImage(named: restaurantImages[indexPath.row])
        
//        cell.nameLabel.text = restaurantNames[indexPath.row]
//        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
//        cell.locationLabel.text = restaurantLocations[indexPath.row]
//        cell.typeLabel.text = restaurantTypes[indexPath.row]
        
        cell.cellSet(name: restaurants[indexPath.row].name, location: restaurants[indexPath.row].location, type: restaurants[indexPath.row].type, thumbnail: restaurants[indexPath.row].image)
        
        if restaurants[indexPath.row].isVisited {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.thumbnailImageView.layer.cornerRadius = 30
        cell.thumbnailImageView.clipsToBounds = true

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //Create an option menu as an action sheet
//        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
//        //Add Cancel actions to the menu
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        optionMenu.addAction(cancelAction)
//        
//        //The Call Action
//        let callActionHandler = { (action: UIAlertAction!) -> Void in
//            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
//            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alertMessage, animated: true, completion: nil)
//        }
//        
//        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
//        optionMenu.addAction(callAction)
//        
//        //The Check-in Action
//        var checkInAction: UIAlertAction
//        if self.restaurants[indexPath.row].isVisited {
//            checkInAction = UIAlertAction(title: "Undo Check in", style: .default, handler: {
//                (action: UIAlertAction!) -> Void in
//                let cell = tableView.cellForRow(at: indexPath)
//                cell?.accessoryType = .none
//                self.restaurants[indexPath.row].isVisited = false
//            })
//        } else {
//            checkInAction = UIAlertAction(title: "Check in", style: .default, handler: {
//                (action: UIAlertAction!) -> Void in
//                let cell = tableView.cellForRow(at: indexPath)
//                cell?.accessoryType = .checkmark
//                self.restaurants[indexPath.row].isVisited = true
//            })
//        }
//        
//        optionMenu.addAction(checkInAction)
//        
//        //Display the menu
//        self.present(optionMenu, animated: true, completion: nil)
//        //Deselect the row
//        tableView.deselectRow(at: indexPath, animated: false)
//        
//    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            //Delete the row from the data source
//            restaurants.remove(at: indexPath.row)
//        }
//        
//        self.tableView.deleteRows(at: [indexPath], with: .fade)
    
//        self.tableView.reloadData()
        
//        print("Total items: \(restaurants.count)")
//        for _ in restaurants {
//            print(restaurants.[indexPath.row].name)
//        }
//    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Social Sharing Button
        let shareAction = UITableViewRowAction(style: .default, title: "Share", handler: {(action, indexPath) -> Void in
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
            
            if let imageToShare = UIImage(named: self.restaurants[indexPath.row].image) {
            let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
            }
            
            })
        
        //Delete button
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {(action, indexPath) -> Void in
            //Delete the row from the data source
            self.restaurants.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            })
        
        shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = restaurants[indexPath.row]
                
                //In this place, I first use the following code:
                ////destinationController.restaurantNameLabel.text = restaurantNames[indexPath.row]
                ////destinationController.restaurantTypeLabel.text = restaurantTypes[indexPath.row]
                ////destinationController.restaurantLocationLabel.text = restaurantLocations[indexPath.row]
                //But it will be crash! Because a segue triggered before the visual transition occurs.
                //That means when the function of prepare called, the destinationController's object which defined in storyboard has not been initialized!
                //So the program crashed and said restaurantName is nil!
                //I resolve this problem by define the restaurantName, restaurantType and restaurantLocation variable in RestaurantDetailViewController, and initialize them as "", and set them in prepare function. they will not be nil.
                //Then pass them to the label text in viewDidLoad method, please see the RestaurantDetailViewController.swift as a reference.
                
            }
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
