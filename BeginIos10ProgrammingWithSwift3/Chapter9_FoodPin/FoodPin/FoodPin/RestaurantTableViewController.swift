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
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", phone: "232-923423", image: "cafedeadend.jpg"),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", phone: "348-233423", image: "homei.jpg"),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", phone: "354-243523", image: "teakha.jpg"),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", phone: "453-333423", image: "cafeloisl.jpg"),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", phone: "983-284334", image: "petiteoyster.jpg"),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", phone: "232-434222", image: "forkeerestaurant.jpg"),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", phone: "234-834322", image: "posatelier.jpg"),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", phone: "232-925523", image: "bourkestreetbakery.jpg"),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", phone: "256-334423", image: "haighschocolate.jpg"),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", phone: "282-667723", image: "palominoespresso.jpg"),
        Restaurant(name: "Upstate", type: "American", location: "New York", phone: "567-115876", image: "upstate.jpg"),
        Restaurant(name: "Traif", type: "American", location: "New York", phone: "902-123453", image: "traif.jpg"),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", phone: "092-923423", image: "grahamavenuemeats.jpg"),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", phone: "232-009223", image: "wafflewolf.jpg"),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", phone: "672-925587", image: "fiveleaves.jpg"),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", phone: "327-921123", image: "cafelore.jpg"),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", phone: "543-920099", image: "confessional.jpg"),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", phone: "232-910293", image: "barrafina.jpg"),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", phone: "232-920203", image: "donostia.jpg"),
        Restaurant(name: "Royal Oak", type: "British", location: "London", phone: "662-198033", image: "royaloak.jpg"),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", phone: "232-120304", image: "caskpubkitchen.jpg")
        ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Remove the back button title in navigation bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //viewDidLoad method only run one time
        //navigationController?.hidesBarsOnSwipe = true
        
    }
    
    //viewWillAppear method would be called every time the view will appear
    //Hide the navigation bar on swipe
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    // You are allow to control the style of status bar in any view controller.
    // Or you could set it through the statusBarStyle property of UIApplication, this lets you change the style of status bar for the entire app.
    // You may add UIApplication.shared.statusBarStyle = .lightContent in app delegate, but before that, you need to set info.list to change the dafault behavor for xcode.
    // By default, the xcode is enabled to use "View controller-based status bar appearance", this means you can control the appearance of the status bar per view controller. in info.plist, add a new key, named "View controller-based status bar appearance" and set it to NO, now, we could change the status bar style by UIApplication.shared.statusBarStyle = .lightContent in app delegate
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    

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
