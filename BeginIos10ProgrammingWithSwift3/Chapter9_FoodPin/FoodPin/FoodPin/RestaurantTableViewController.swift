//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by LiZhen on 2016/11/30.
//  Copyright © 2016年 LiZhen. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
//    var restaurants:[Restaurant] = [
//            Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", image: "cafedeadend.jpg"),
//            Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", phone: "348-233423", image:
//                "homei.jpg"),
//            Restaurant(name: "Teakha", type: "Tea House", location: "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "354-243523", image:
//                "teakha.jpg"),
//            Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "453-333423", image: "cafeloisl.jpg"),
//            Restaurant(name: "Petite Oyster", type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "983-284334", image:
//                    "petiteoyster.jpg"),
//            Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Shop JK., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", phone: "232-434222",
//                    image: "forkeerestaurant.jpg"),
//            Restaurant(name: "Po's Atelier", type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", phone: "234-834322", image: "posatelier.jpg"),
//            Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", phone: "982-434343", image:
//                    "bourkestreetbakery.jpg"),
//            Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney New South Wales", phone: "734-232323", image:
//                    "haighschocolate.jpg"),
//            Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Shop 1 61 York St Sydney New South Wales", phone: "872-734343", image:
//                    "palominoespresso.jpg"),
//            Restaurant(name: "Upstate", type: "American", location: "95 1st Ave New York, NY 10003", phone: "343-233221", image: "upstate.jpg"),
//            Restaurant(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY 11211", phone: "985-723623", image: "traif.jpg"),
//            Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "445 Graham Ave Brooklyn, NY 11211", phone: "455-232345", image:
//                        "grahamavenuemeats.jpg"),
//            Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave Brooklyn, NY 11211", phone: "434-232322", image: "wafflewolf.jpg"),
//            Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "18 Bedford Ave Brooklyn, NY 11222", phone: "343-234553", image: "fiveleaves.jpg"),
//            Restaurant(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", phone: "342-455433", image:
//                        "cafelore.jpg"),
//            Restaurant(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY 10003", phone: "643-332323", image: "confessional.jpg"),
//            Restaurant(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D 4SL United Kingdom", phone: "542-343434", image: "barrafina.jpg"),
//            Restaurant(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H 7ND United Kingdom", phone: "722-232323", image: "donostia.jpg"),
//            Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", phone: "343-988834", image: "royaloak.jpg"),
//            Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "22 Charlwood Street London SW1V 2DY Pimlico", phone: "432-344050", image:
//                        "caskpubkitchen.jpg")
//        ]
    
    var restaurants: [RestaurantMO] = []
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    var searchController: UISearchController!
    var searchResults: [RestaurantMO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Remove the back button title in navigation bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //Set up self sizing cell
        self.tableView.estimatedRowHeight = 36.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        //viewDidLoad method only run one time
        //navigationController?.hidesBarsOnSwipe = true
        
        //Fetch. Using NSFetchedResultsController
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            self.fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurants = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        
        //Create a search bar
        self.searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.searchController.searchBar.placeholder = "Search restaurants..."
        self.searchController.searchBar.tintColor = UIColor.white
        self.searchController.searchBar.barTintColor = UIColor(red: 218.0/255.0, green: 100.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        
    }
    
    //viewWillAppear method would be called every time the view will appear
    //Hide the navigation bar on swipe
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        
        //Present the walkthrough screen
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughController") as? WalkthroughPageViewController {
            self.present(pageViewController, animated: true, completion: nil)
        }
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
        if self.searchController.isActive {
            return searchResults.count
        } else {
            return restaurants.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        //Determine if we get the restaurant from search result or the original array
        let restaurant = (self.searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]

        // Configure the cell...
//        cell.textLabel?.text = restaurantNames[indexPath.row]
//        cell.imageView?.image = UIImage(named: restaurantImages[indexPath.row])
        
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(data: restaurant.image as! Data)
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        
//        cell.cellSet(name: restaurants[indexPath.row].name, location: restaurants[indexPath.row].location, type: restaurants[indexPath.row].type, thumbnail: restaurants[indexPath.row].image)
        
        if restaurant.isVisited {
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if self.searchController.isActive {
            return false
        } else {
            return true
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Social Sharing Button
        let shareAction = UITableViewRowAction(style: .default, title: "Share", handler: {(action, indexPath) -> Void in
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name!
            
            if let imageToShare = UIImage(data: self.restaurants[indexPath.row].image as! Data) {
            let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
            }
            
            })
        
        //Delete button
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {(action, indexPath) -> Void in
            //Delete the row from the data source
//            self.restaurants.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .fade)
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)
                
                appDelegate.saveContext()
            }
            })
        
        shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                //destinationController.restaurant = restaurants[indexPath.row]
                destinationController.restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
                
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
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        
    }
    
    // MARK: - NSFetchedResultsControllerDelegate method
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                self.tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            self.tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            restaurants = fetchedObjects as! [RestaurantMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    // MARK: - Method for deal with search
    //Logic for search
    func filterContent(for searchText: String) {
        self.searchResults = restaurants.filter({ (restaurant) -> Bool in
            if let name = restaurant.name, let location = restaurant.location {
                let isMatch = name.localizedCaseInsensitiveContains(searchText) || location.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
    }
    
    //The method for UISearchResultsUpdating protocol. When a user selects the search bar or key in a search keyword, the method will be called
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = self.searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
 

}
