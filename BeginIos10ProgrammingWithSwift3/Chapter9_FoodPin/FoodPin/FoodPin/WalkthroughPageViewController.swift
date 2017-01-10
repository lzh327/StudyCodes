//
//  WalkthroughPageViewController.swift
//  FoodPin
//
//  Created by lizhen on 2016/12/31.
//  Copyright © 2016年 LiZhen. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var pageHeadings = [NSLocalizedString("Personalize", comment: "Personalize Field"), NSLocalizedString("Locate", comment: "Locate Field"), NSLocalizedString("Discover", comment: "Discover Field")]
    var pageImages = ["foodpin-intro-1", "foodpin-intro-2", "foodpin-intro-3"]
    var pageContent = [NSLocalizedString("Pin your favorite restaurants and create your own food guide", comment: "Personalize discriptive Field"),
                       NSLocalizedString("Search and locate your favourite restaurant on Maps", comment: "Locate discriptive Field"),
                       NSLocalizedString("Find restaurants pinned by your friends and other foodies around the world", comment: "Discover discriptive Field")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the data source to itself
        dataSource = self
        
        //Create the first walkthrough screen
        if let startingViewController = self.contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIPageViewControllerDataSource protocol methods
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
//        print("enter viewControllerBefore method")
//        print("\(index)")
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
//        print("enter viewControllerAfter method")
//        print("\(index)")
        
        return contentViewController(at: index)
    }
    
    //The default page indicator is not good, we can't customize its position or other customizations. We should implement a custom page control
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return self.pageHeadings.count
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
//            return pageContentViewController.index
//        }
//        return 0
//    }
    
    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= self.pageHeadings.count {
            return nil
        }
        
        //Create a new view controller and pass suitable data
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            pageContentViewController.imageFile = self.pageImages[index]
            pageContentViewController.heading = self.pageHeadings[index]
            pageContentViewController.content = self.pageContent[index]
            pageContentViewController.index = index
            
            //At the first time, I forget to write the last statement, pageContentViewController.index = index
            //Then I meet a bug that the page view always display the content view of index 1, because the content view will always instantialize as index 0, and in the viewControllerAfter method, the index will become 1, so I always display index 1 view.
            
            return pageContentViewController
        }
        
        return nil
    }
    
    func forward(index: Int) {
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
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
