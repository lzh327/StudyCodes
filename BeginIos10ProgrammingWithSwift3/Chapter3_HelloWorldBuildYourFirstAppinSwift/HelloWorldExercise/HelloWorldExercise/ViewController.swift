//
//  ViewController.swift
//  HelloWorldExercise
//
//  Created by lizhen on 2016/11/8.
//  Copyright © 2016年 lizhen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMessage1() {
        let alertController = UIAlertController(title: "Welcome to My First App", message: "Hello World", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    //This place, I first declare the action with showMessage(_ sender: Any), but I found that only button1 could connect with the IBAction, the other 3 button could not connect with it.
    //So, I write the @IBAction with showMessage1() in the editor, then connect the button with it, this way could connect all of the button with one action.
    //The result is if there are parameters in the action function, I can't connect the button with it.
    //if there is no parameter with the function, I could connect with it.
    
    //I tested to change the type of sender from Any to UIButton, it works, and all button could connect with it.
    //@IBAction func smallButtonPressed(_ sender: Any)           wrong
    //@IBAction func smallButtonPressed(_ sender: UIButton)      correct


    @IBAction func smallButtonPressed(_ sender: UIButton) {
        let buttonTitle = sender.title(for: UIControlState.normal)
        switch buttonTitle! {
        case "left":
            label.text = "left button tapped"
        case "right":
            label.text = "right button tapped"
        default:
            break
        }
    }

}

