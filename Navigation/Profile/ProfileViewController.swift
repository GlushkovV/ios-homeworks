//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 24.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.delegate = self
        return view
    }()

    private lazy var newButton: UIButton = {
        let button = UIButton()
        button.setTitle("Новая кнопка", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        title = "Профиль"
        //self.navigationController?.navigationBar.isHidden = true
        self.setupView()
        
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.profileHeaderView)
        self.view.addSubview(self.newButton)
        let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        self.heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 245)
        let bottomNewButtonConstraint = self.newButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        let leadingNewButtonConstraint = self.newButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let trailingNewButtonConstraint = self.newButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let heightNewButtonConstraint = self.newButton.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, self.heightConstraint,
            bottomNewButtonConstraint, leadingNewButtonConstraint, trailingNewButtonConstraint,
            heightNewButtonConstraint
        ].compactMap({ $0 }))
    }
}

extension ProfileViewController: ProfileHeaderViewProtocol {
    
    func didTapShowStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = textFieldIsVisible ? 300 : 245
        UIView.animate(withDuration: 0.3, delay: 0.1) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}
