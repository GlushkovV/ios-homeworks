//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 24.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        title = "Профиль"
    }
    
}
