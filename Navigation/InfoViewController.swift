//
//  InfoViewController.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 26.02.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        title = "Информация"
        let button = UIButton(frame: CGRect(x: 130, y: 770, width: 150, height: 40))
        view.addSubview(button)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.setTitle("Подробнее", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(alertClicked), for: .touchUpInside)
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func alertClicked() {
        let alert = UIAlertController(title: "Заголовок", message: "Текст некого сообщения", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ок", style: .default, handler: nil)
        let cancelButton = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
}
