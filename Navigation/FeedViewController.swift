//
//  FeedViewController.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 24.02.2022.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        title = "Лента"
        let button = UIButton(frame: CGRect(x: 130, y: 770, width: 150, height: 40))
        view.addSubview(button)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.setTitle("Перейти на сообщение", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func buttonClicked() {
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
        
        struct Post {
            let title:String = "Сообщение"
        }
        
        let post = Post()
        postViewController.title = post.title
        }
        
}
