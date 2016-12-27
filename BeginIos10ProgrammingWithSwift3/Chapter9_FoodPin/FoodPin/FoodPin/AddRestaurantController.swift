//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by LiZhen on 2016/12/27.
//  Copyright © 2016年 LiZhen. All rights reserved.
//

import UIKit

class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.restaurant = Restaurant(name: "", type: "", location: "", phone: "", image: "")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        print("Save button has been tapped!")
        if self.nameTextField.text == "" || self.typeTextField.text == "" || self.locationTextField.text == "" {
            let alert = UIAlertController(title: "OOPS", message: "We can't proceed because one of the field is blank. Please note that all field are required.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.restaurant.name = self.nameTextField.text!
            self.restaurant.type = self.typeTextField.text!
            self.restaurant.location = self.locationTextField.text!
            
            print("Name: \(self.nameTextField.text)")
            print("Type: \(self.typeTextField.text)")
            print("Location: \(self.locationTextField.text)")
            print("Have you been here: \(self.restaurant.isVisited)")
            
            //connect addRestaurantController to HomeScreen with show segue. And name the identifier with "unwindToHomeScreen"
            performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
        }
    }
    
    @IBAction func toggleBeenHereButton(_ sender: UIButton) {
        //Yes button clicked
        if sender == self.yesButton {
            self.restaurant.isVisited = true
            self.yesButton.backgroundColor = UIColor.red
            self.noButton.backgroundColor = UIColor.gray
        } else if sender == self.noButton {
            self.restaurant.isVisited = false
            self.yesButton.backgroundColor = UIColor.gray
            self.noButton.backgroundColor = UIColor.red
        }
    }
    
    
    //When the user select the first row, bring up photo library. You must add the key of "Privacy - Photo Library Usage Description" into info.list, and set some descript string for the value.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    //The method of UIImagePickerControllerDelegate protocol, implement it to select the image from photo library.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.photoImageView.image = selectedImage
            self.photoImageView.contentMode = .scaleAspectFill
            self.photoImageView.clipsToBounds = true
        }
        
        //Set the auto layout by NSLayoutConstraint, it is same with Size inspector when select a layout constraint in Interface Builder
        let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraints = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        topConstraints.isActive = true
        
        let bottomConstraints = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        bottomConstraints.isActive = true
        
        //dismiss the image picker
        self.dismiss(animated: true, completion: nil)
    }

 
}
