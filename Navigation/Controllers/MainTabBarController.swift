//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 24.02.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
        view.backgroundColor = .systemBackground
    }
    
    func setupTabBar() {
        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "house"), tag: 0)
        //let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        let profileViewController = UINavigationController(rootViewController: LogInViewController())
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.fill"), tag: 0)
        
        viewControllers = [feedViewController, profileViewController]
    }
    
}
