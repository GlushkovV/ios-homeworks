//
//  AvatarView.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 30.03.2022.
//

import UIKit

final class AvatarView: UIView {

    private lazy var alphaView: UIView = {
        let view = UIView()
        view.alpha = 0.7
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Photo"))
        //imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(systemName: "xmark.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let screenWidth = UIScreen.main.bounds.width
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.backgroundColor = .clear
        self.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(alphaView)
        addSubview(avatarImageView)
        addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: screenWidth),
            avatarImageView.widthAnchor.constraint(equalToConstant: screenWidth),
            alphaView.topAnchor.constraint(equalTo: self.topAnchor),
            alphaView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            alphaView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            alphaView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func didTapCloseButton() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        }
    }

}
