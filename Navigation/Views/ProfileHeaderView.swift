//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 27.02.2022.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Photo"))
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Виталий"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .lightGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Статус"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить статус", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        //button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(self.didTapSetStatusButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Новый статус"
        textField.returnKeyType = .done
        textField.autocapitalizationType = .words
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        textField.textColor = .black //.systemGray2
        textField.backgroundColor = .white //.systemGray4
        textField.layer.cornerRadius = 10
        //textField.borderStyle = .roundedRect
        textField.setLeftPaddingPoints(10)
        textField.textAlignment = .left
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.returnKeyType = .next
        textField.keyboardType = .default
        textField.clearButtonMode = .always
        textField.alpha = 0
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHidden = true
        return textField
    }()
 
    private var heightConstraint: NSLayoutConstraint?
    private var topSetStatusButtonOn: NSLayoutConstraint?
    private var topSetStatusButtonOff: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapKeyboardOff(_:)))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawSelf() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(statusTextField)
        
        self.topSetStatusButtonOn = self.setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16)
        self.topSetStatusButtonOn?.priority = UILayoutPriority(rawValue: 999)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150),
            
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 182),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            self.topSetStatusButtonOn,
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -18),
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor)
        ].compactMap({ $0 }))
    }
    
    @objc private func didTapSetStatusButton() {
        if self.statusTextField.isHidden {
            self.statusTextField.alpha = 1
            NSLayoutConstraint.deactivate([self.topSetStatusButtonOff].compactMap({ $0 }))
            
            self.topSetStatusButtonOn = self.setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 50)
            
            NSLayoutConstraint.activate([
                statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 27),
                statusTextField.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
                statusTextField.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
                statusTextField.heightAnchor.constraint(equalToConstant: 34),
                self.topSetStatusButtonOn
            ].compactMap({ $0 }))
            
        } else {
            self.statusTextField.isHidden = false
            self.statusTextField.alpha = 0
            NSLayoutConstraint.deactivate([self.topSetStatusButtonOn].compactMap({ $0 }))
            if self.statusTextField.text != "" {
                self.statusLabel.text = self.statusTextField.text
                self.statusTextField.text = .none
                self.statusLabel.textColor = .black
            } else {
                self.statusLabel.shake()
                self.statusLabel.textColor = .gray
                self.statusLabel.text = "Статус"
            }
            self.topSetStatusButtonOff = self.setStatusButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 16)
            NSLayoutConstraint.activate([self.topSetStatusButtonOff].compactMap({ $0 }))
        }
        self.endEditing(true) //self.statusTextField.endEditing(true)
        self.didTapShowStatusButton(textFieldIsVisible: self.statusTextField.isHidden) { [weak self] in
            self?.statusTextField.isHidden.toggle()
        }
    }
    
    func didTapShowStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = textFieldIsVisible ? 290 : 245
        UIView.animate(withDuration: 0.3, delay: 0.1) {
            self.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
    
    @objc private func tapKeyboardOff(_ sender: Any) {
        statusTextField.resignFirstResponder()
    }
    
}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
