//
//  TabController.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 4/30/24.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTaps() 
        self.selectedIndex = 0

    }
    private func setupTaps(){
        let home = self.createNav(with: "홈", and: UIImage(systemName: "house"), vc: HomeController())
        let expect = self.createNav(with: "공개예정", and: UIImage(systemName: "video"), vc: ExpectedController())
        let search = self.createNav(with: "검색", and: UIImage(systemName: "magnifyingglass"), vc: SearchController())
        let log = self.createNav(with: "기록", and: UIImage(systemName: "clock"), vc: LogController())
        self.setViewControllers([home, expect, search, log], animated: true)
    }
    private func createNav(with title: String, and image:UIImage?, vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title + "Controller"
        
        return nav
    }
    



}
