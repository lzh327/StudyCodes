//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by lizhen on 2016/12/31.
//  Copyright © 2016年 LiZhen. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var forwardButton: UIButton!
    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        
        switch index {
        case 0...1: forwardButton.setTitle(NSLocalizedString("NEXT", comment: "NEXT Field"), for: .normal)
        case 2: forwardButton.setTitle(NSLocalizedString("DONE", comment: "DONE Field"), for: .normal)
        default: break
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        switch index {
        case 0...1:
            let pageViewController = self.parent as! WalkthroughPageViewController
            pageViewController.forward(index: index)
        case 2:
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
            self.dismiss(animated: true, completion: nil)
        default:
            break
        }
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
