//
//  TabBarVC.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 10/11/22.
//

import Foundation
import UIKit
import SnapKit

@available(iOS 16.0, *)
class TabBarVC: UITabBarController, UITabBarControllerDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond toUITabBarControllerDelegate methods
        self.delegate = self
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        let normalTA = [NSAttributedString.Key.foregroundColor : UIColor(.gray), NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 13)!]
        let selectedTA = [NSAttributedString.Key.foregroundColor : K.Color.greenQuint, NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 13)!]
        
        tabBarItemAppearance.normal.titleTextAttributes = normalTA
        tabBarItemAppearance.selected.titleTextAttributes = selectedTA

        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
        
        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
        self.tabBar.clipsToBounds = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : K.Color.greenQuint, NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 13)!], for: .selected)
        
        // Routine tab
        let tabOne = UINavigationController(rootViewController: RoutineVC())
        let tabOneBarItem = UITabBarItem(title: "Routine", image: UIImage(named:"TabBarRoutine"), selectedImage: UIImage(named: "TabBarRoutineSelected"))
        tabOne.tabBarItem = tabOneBarItem
        
        
        // Treatment tab
        let tabTwo = UINavigationController(rootViewController: TreatmentsVC())
        let tabTwoBarItem = UITabBarItem(title: "Treatment", image: UIImage(named:"TabBarTreatment"), selectedImage: UIImage(named: "TabBarTreatmentSelected"))
        
        tabTwo.tabBarItem = tabTwoBarItem
        
        let tabThree = UINavigationController(rootViewController: RoutineHistoryVC())
        
        let tabThreeBarItem = UITabBarItem(title: "History", image: UIImage(named:"TabBarHistory"), selectedImage: UIImage(named: "TabBarHistorySelected"))
        
        tabThree.tabBarItem = tabThreeBarItem
        
        // Profile tab
        let tabFour = UINavigationController(rootViewController: ProfileVC())
        let tabFourBarItem = UITabBarItem(title: "Profile", image: UIImage(named:"TabBarProfile"), selectedImage: UIImage(named: "TabBarProfileSelected"))
        
        tabFour.tabBarItem = tabFourBarItem
        
        let tabBars = [tabOne, tabTwo, tabThree, tabFour]
        tabBars.forEach { vc in
            vc.tabBarItem.image = vc.tabBarItem.image?.withRenderingMode(.alwaysTemplate)
            vc.tabBarItem.selectedImage = vc.tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal)
        }
        
        self.viewControllers = [tabOne, tabTwo, tabThree, tabFour]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController:UIViewController) {
        print("Selected tab")
    }
}
