//
//  TabBarController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 12/02/2017.
//  Copyright © 2017 BMSTU Team. All rights reserved.
//

import UIKit

enum TabIndex: Int {
    case schedule = 0
    case groups   = 1
    case settings = 2
}

class TabBarController: UITabBarController {

    // MARK: Constants
    
    let tabBarHeight: CGFloat = 45
    let tabTitleFont = UIFont.systemFont(ofSize: 10)
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Normal
        //FIXME: Some troubles to use appearance
        //UIAppearance.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppTheme.current.ligthGrayColor,
        //                                                  NSAttributedStringKey.font: self.tabTitleFont], for: .normal)
        
        // Selected
        for item in self.tabBar.items! as [UITabBarItem] {
            if let image = item.image, let selectedImage = item.selectedImage {
                
                // Normal
                item.image = image.imageWithColor(newColor: AppTheme.current.ligthGrayColor).withRenderingMode(.alwaysOriginal)
                
                // Selected
                let index = TabIndex(rawValue: self.tabBar.items!.index(of: item)!) ?? .schedule
                switch index {
                case .schedule:
                    item.selectedImage = selectedImage.imageWithColor(newColor: AppTheme.current.greenColor).withRenderingMode(.alwaysOriginal)
                    item.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppTheme.current.greenColor,
                                                 NSAttributedStringKey.font: self.tabTitleFont], for: .selected)
                    break
                case .groups:
                    item.selectedImage = selectedImage.imageWithColor(newColor: AppTheme.current.blueColor).withRenderingMode(.alwaysOriginal)
                    item.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppTheme.current.blueColor,
                                                 NSAttributedStringKey.font: self.tabTitleFont], for: .selected)
                    break
                case .settings:
                    item.selectedImage = selectedImage.imageWithColor(newColor: AppTheme.current.defaultsColor).withRenderingMode(.alwaysOriginal)
                    item.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppTheme.current.defaultsColor,
                                                 NSAttributedStringKey.font: self.tabTitleFont], for: .selected)
                    break
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = self.tabBarHeight
        tabFrame.origin.y = self.view.frame.size.height - self.tabBarHeight
        self.tabBar.frame = tabFrame
    }
}