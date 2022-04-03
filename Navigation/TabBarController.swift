//
//  TabBarController.swift
//  Navigation
//
//  Created by OksanaS on 16.03.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    private enum TabBarItem {
        case newstipe
        case profile
        case gesture
        
        var title: String {
            switch self {
            case .newstipe:
                return "Лента"
            case .profile:
                return "Профиль"
            case.gesture:
                return "Анимация"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .newstipe:
                return UIImage(systemName: "doc.text.fill")
            case .profile:
                return UIImage(systemName: "person.crop.artframe")
            case .gesture:
                return UIImage(systemName: "dot.circle.and.hand.point.up.left.fill")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
    
    func setupTabBar() {
        let items: [TabBarItem] = [ .newstipe, .profile, .gesture]
        self.viewControllers = items.map({tabBarItem in
            switch tabBarItem {
            case .newstipe:
                return UINavigationController(rootViewController: FeedViewController())
            case .profile:
                return UINavigationController(rootViewController: LogInViewController()) //поменяли на др страничку вместо Profile
            case .gesture:
                return UINavigationController(rootViewController: AnimatedViewController())
            }
        })
        
        self.viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = items[index].title
            vc.tabBarItem.image = items[index].image
            
        })
    }
}
