//
//  ViewController.swift
//  Samemoon
//
//  Created by Hector Aguilar on 01/Feb/18.
//  Copyright © 2018 Hector Aguilar. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController, UIPageViewControllerDataSource{
    
    let preferences = NSUserDefaults.standardUserDefaults()
    let currentLevelKey = "arrayUsuario"
    
    
    
    var arrPageTitle: NSArray = NSArray()
    var arrPagePhoto: NSArray = NSArray()
    var arrPageSlider: NSArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrPageTitle = ["Titulo 1","Titulo 2","Titulo 3","Titulo 4"]
        self.arrPagePhoto = ["bienvenida1","bienvenida2","bienvenida3","bienvenida4"]
        self.arrPageSlider = ["slide1","slide2","slide3","slide1"]
        
        
        self.dataSource = self
        
        self.setViewControllers([getViewControllerAtIndex(0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if preferences.objectForKey(currentLevelKey) == nil {
            //  Doesn't exist
        } else {
            
            /*
            //let currentLevel = preferences.objectForKey(currentLevelKey)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("RegisterController") as! RegisterViewController
            self.presentViewController(nextViewController, animated:false, completion:nil)
            
            
            return
            */
        }
        

    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PagePantalla2Controller = viewController as! PagePantalla2Controller
        var index = pageContent.pageIndex
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        index -= 1
        return getViewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PagePantalla2Controller = viewController as! PagePantalla2Controller
        var index = pageContent.pageIndex
        if (index == NSNotFound)
        {
            return nil;
        }
        index += 1
        if (index == arrPageTitle.count)
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("RegisterController") as! RegisterViewController
            self.presentViewController(nextViewController, animated:false, completion:nil)
            
            return nil
        }
        return getViewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int{
        return arrPageTitle.count
    }
    
    func getViewControllerAtIndex(index: NSInteger) -> PagePantalla2Controller
    {
        // Create a new view controller and pass suitable data.
        
       
            let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! PagePantalla2Controller
            pageContentViewController.titleIndex = "\(arrPageTitle[index])"
            pageContentViewController.imageFIle = "\(arrPagePhoto[index])"
            pageContentViewController.textoSlider = "\(arrPageSlider[index])"
            pageContentViewController.pageIndex = index
            return pageContentViewController
        
        
      
        
    }
    
}


