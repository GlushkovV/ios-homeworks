//
//  DetailPhotoView.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 27.03.2022.
//

import UIKit

final class DetailPhotoView: UIView {

    lazy var photoView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    } ()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(systemName: "xmark.circle.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
        self.backgroundColor = .systemBackground
        self.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(photoView)
        self.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
                      
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10.0),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            
            photoView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            
        ])
    }
    
    @objc private func didTapCloseButton() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        }
    }
    

}
