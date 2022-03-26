//
//  AnimationsViewController.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 24.03.2022.
//

import UIKit

final class AnimationsViewController: UIViewController {
    
    private lazy var avatarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = .systemBackground
        return view
    } ()
    
    private lazy var alphaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    } ()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Photo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    } ()
    
    private lazy var testLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Проверка размытости фона"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.alpha = 0
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(systemName: "xmark.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let tapGestureRecognizer = UITapGestureRecognizer()
    private var avatarViewCenterXConstraint: NSLayoutConstraint?
    private var avatarViewCenterYConstraint: NSLayoutConstraint?
    private var avatarViewHeightConstraint: NSLayoutConstraint?
    private var avatarViewWidthConstraint: NSLayoutConstraint?
    private var isExpanded = false
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .systemGray6
        title = "Жесты и анимация"
        self.setupView()
        self.setupGesture()
    }
    
    private func setupView() {
        view.addSubview(testLabel)
        view.addSubview(alphaView)
        view.addSubview(self.avatarView)
        avatarView.addSubview(self.avatarImageView)
        view.bringSubviewToFront(alphaView)
        view.addSubview(closeButton)
        view.bringSubviewToFront(avatarView)
        self.avatarView.layer.cornerRadius = 75
        self.alphaView.alpha = 0
        
        self.avatarViewCenterXConstraint = self.avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -1 * (screenWidth * 0.5 - 91))
        self.avatarViewCenterYConstraint = self.avatarView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -1 * (screenHeight * 0.5 - 166))
        self.avatarViewHeightConstraint = self.avatarView.heightAnchor.constraint(equalToConstant: 150)
        self.avatarViewWidthConstraint = self.avatarView.widthAnchor.constraint(equalToConstant: 150)
        
        NSLayoutConstraint.activate([
            self.avatarViewCenterXConstraint, self.avatarViewCenterYConstraint,
            self.avatarViewHeightConstraint, self.avatarViewWidthConstraint,
            avatarImageView.topAnchor.constraint(equalTo: avatarView.topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor),
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            testLabel.widthAnchor.constraint(equalToConstant: 200),
            alphaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            alphaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            alphaView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            alphaView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ].compactMap({ $0 }))
    }
    
    private func setupGesture() {
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.handleTapGesture(_ :)))
        self.avatarView.addGestureRecognizer(self.tapGestureRecognizer)
    }
    
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapGestureRecognizer === gestureRecognizer else {return}
        self.isExpanded.toggle()
        self.avatarViewCenterXConstraint?.constant = self.isExpanded ? 0 : -1 * (screenWidth * 0.5 - 91)
        self.avatarViewCenterYConstraint?.constant = self.isExpanded ? 0 : -1 * (screenHeight * 0.5 - 166)
        self.avatarViewHeightConstraint?.constant = self.isExpanded ? screenWidth : 150
        self.avatarViewWidthConstraint?.constant = self.isExpanded ? screenWidth : 150
    
        UIView.animate(withDuration: 0.5) {
            self.avatarView.layer.cornerRadius = self.isExpanded ? 0 : 75
            self.alphaView.alpha = self.isExpanded ? 0.7 : 0
            self.view.layoutIfNeeded()
        } completion: { _ in
        }
        
        if self.isExpanded {
            self.alphaView.isHidden = false
            self.closeButton.isHidden = false
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.closeButton.alpha = self.isExpanded ? 1 : 0
        } completion: { _ in
            self.closeButton.isHidden = !self.isExpanded
        }
    }
    
    @objc private func didTapCloseButton() {
        self.avatarViewCenterXConstraint?.constant = -1 * (screenWidth * 0.5 - 91)
        self.avatarViewCenterYConstraint?.constant = -1 * (screenHeight * 0.5 - 166)
        self.avatarViewHeightConstraint?.constant = 150
        self.avatarViewWidthConstraint?.constant = 150
        
        UIView.animate(withDuration: 0.5) {
            self.avatarView.layer.cornerRadius = 75
            self.alphaView.alpha = 0
            self.view.layoutIfNeeded()
            self.closeButton.alpha = 0
        } completion: { _ in
            self.closeButton.isHidden = false
            self.isExpanded = false
        }
    }
       
}
