//
//  FeedViewController.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 24.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    struct Post {
        let title:String = "Сообщение"
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemBackground
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var oneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Первая кнопка", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var twoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вторая кнопка", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        title = "Лента"
        view.addSubview(stackView)
        stackView.addArrangedSubview(oneButton)
        stackView.addArrangedSubview(twoButton)
        let centerYStackViewConstraint = self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let leadingStackViewConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10)
        let trailingStackViewConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        let heightStackViewConstraint = self.stackView.heightAnchor.constraint(equalToConstant: 110)
        NSLayoutConstraint.activate([
            centerYStackViewConstraint, leadingStackViewConstraint, trailingStackViewConstraint,
            heightStackViewConstraint
        ])
    }
        /*
        let button = UIButton(frame: CGRect(x: 130, y: 770, width: 150, height: 40))
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
    */
    
    @objc func buttonClicked() {
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
        let post = Post()
        postViewController.title = post.title
        }
        
}
