//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by LiZhen on 2016/12/22.
//  Copyright © 2016年 LiZhen. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var containImageView: UIImageView!
    @IBOutlet var closeButton: UIButton!
    
    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundImageView.image = UIImage(named: self.restaurant.image)
        self.containImageView.image = UIImage(named: self.restaurant.image)
        
        //Add blur effect to backgroud
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        self.backgroundImageView.addSubview(blurEffectView)
        
        //Scale the container view to zero
//        self.containerView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        
        //Example of Slide down animation, change the view's position
        //At first, I set the argument y = -1000 as the book said, but I found that it is a little strange because the container view will be seen when the ReviewView finished load, and then the animation start.
        //The reason is that the ReviewView is coming from bottom, then -1000 is just in the screen, so I modified it from -1000 to -2000, then the problem has been resolved.
//        self.containerView.transform = CGAffineTransform.init(translationX: 0, y: -2000)
        
        //Combining two transforms
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -2000)
        let combineTransform = scaleTransform.concatenating(translateTransform)
        self.containerView.transform = combineTransform
        
        //Close button animation
        let translateTransformForClose = CGAffineTransform.init(translationX: 500, y: 0)
        self.closeButton.transform = translateTransformForClose

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Animate the container view
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.transform = CGAffineTransform.identity
        })
        
        //At first, I made a close button animation without delay, it is not good
//        UIView.animate(withDuration: 0.3, animations: {
//            self.closeButton.transform = CGAffineTransform.identity
//        })
        //A close button animation with delay
        UIView.animate(withDuration: 1.0, delay: 0.3, options: .curveEaseOut, animations: {
            self.closeButton.transform = CGAffineTransform.identity
        }, completion: nil)
        
        //Example of Spring animation
//        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
//            self.containerView.transform = CGAffineTransform.identity
//        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
