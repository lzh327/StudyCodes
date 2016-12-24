//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by LiZhen on 2016/12/9.
//  Copyright © 2016年 LiZhen. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var mapView: MKMapView!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        self.restaurantImageView.image = UIImage(named: self.restaurant.image)
        self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        //self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        // Display the restaurant name in the navigation bar
        self.title = restaurant.name
        
        //Set up self sizing cell
        self.tableView.estimatedRowHeight = 36.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        //viewDidLoad method only run one time
        //navigationController?.hidesBarsOnSwipe = false
        
        //Add a tap gesture and attach it to the map view, this will implement tapping the map to show the map view controller
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap))
        mapView.addGestureRecognizer(tapGestureRecognizer)
        
        //Converting an address into coordinates using Geocoder and adding an annotation to the map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks, error in
            if error != nil {
                print(error!)
                return
            }
            
            if let placemarks = placemarks {
                //Get the first placemark
                let placemark = placemarks[0]
                
                //Add annotation
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location {
                    //Display the annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    //Set the zoom level
                    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
            
        })
        
        
    }
    
    //viewWillAppear method would be called every time the view will appear
    //Unhide the navigation bar on swipe and show it
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //Use for unwind segue, when connect in the Interface Builder, this function displayed as closeWithSegue
    @IBAction func close(segue: UIStoryboardSegue) {
        //print("The close function has been called!")
    }
    
    //Use for unwind segue, when connect in the Interface Builder, this function displayed as ratingButtonTappedWithSegue
    @IBAction func ratingButtonTapped(segue: UIStoryboardSegue) {
        if let rating = segue.identifier {
            self.restaurant.isVisited = true
            
            switch rating {
            case "great":
                self.restaurant.rating = "Absolutely love it! Must try."
            case "good":
                self.restaurant.rating = "Pretty good."
            case "dislike":
                self.restaurant.rating = "I don't like it."
            default:
                break
            }
        }
        
        self.tableView.reloadData()
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
            cell.valueLabel.text = (self.restaurant.isVisited) ? "Yes, I have been here before. \(self.restaurant.rating)" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReview" {
            let destinationController = segue.destination as! ReviewViewController
            destinationController.restaurant = self.restaurant
        } else if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            destinationController.restaurant = self.restaurant
        }
    }
    
    func showMap() {
        performSegue(withIdentifier: "showMap", sender: self)
    }
}
