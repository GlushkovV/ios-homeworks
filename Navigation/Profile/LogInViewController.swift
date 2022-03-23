//
//  LogInViewController.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 13.03.2022.
//

import UIKit

final class LogInViewController: UIViewController {
    
    let customLightBlueColor = UIColor(hex: "#4885CC")
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    } ()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .systemBackground
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    } ()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private lazy var loginPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemGray6
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.cornerRadius = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Email or phone"
        textField.font = .systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.textColor = .black
        textField.layer.borderWidth = 0.5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.font = .systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.textColor = .black
        textField.layer.borderWidth = 0.5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
    
    private lazy var loginInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(loginInButton)
        contentView.addSubview(loginPasswordStackView)
        loginPasswordStackView.addArrangedSubview(loginTextField)
        loginPasswordStackView.addArrangedSubview(passwordTextField)
        self.setupConstraints()
        self.hidingKeyboard()
        self.navigationController?.navigationBar.isHidden = true
        let notificationCenterKeyboard = NotificationCenter.default
        notificationCenterKeyboard.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenterKeyboard.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

    }
    
    @objc private func adjustForKeyboard(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let screenHeight = UIScreen.main.bounds.height
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let difference = keyboardHeight - ((screenHeight / 2) - 130)
            if ((screenHeight / 2) - 120) <= keyboardHeight {
                let contentOffset: CGPoint = notification.name == UIResponder.keyboardWillHideNotification ? .zero : CGPoint(x: 0, y:  difference)
                self.scrollView.setContentOffset(contentOffset, animated: true)
            }
        }
    }
    
    private func hidingKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func setupConstraints () {
        let topConstraints = self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leftConstraints = self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        let rightConstraints = self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        let bottomConstraints = self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        let contentViewTopConstraints = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let contentViewBottomConstraints = self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        let contentViewLeadingConstraints = self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor)
        let contentViewTrailingConstraints = self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor)
        let contentViewCenterXConstraints = self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let contentViewCenterYConstraints = self.contentView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor)
        let contentViewWidthConstraints = self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let contentViewHeightConstraints = self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        
        let logoImageViewBottomConstraints = self.logoImageView.bottomAnchor.constraint(equalTo: self.loginPasswordStackView.topAnchor, constant: -120)
        let logoImageViewCenterXConstraints = self.logoImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        let logoImageViewHeightConstraints = self.logoImageView.heightAnchor.constraint(equalToConstant: 100)
        let logoImageViewWidthConstraints = self.logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 1.0)
        //let logoImageViewWidthConstraints = self.logoImageView.widthAnchor.constraint(equalToConstant: 100)
        
        let loginPasswordStackViewCenterYConstraints = self.loginPasswordStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        let loginPasswordStackViewLeftConstraints = self.loginPasswordStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let loginPasswordStackViewRightConstraints = self.loginPasswordStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let loginPasswordStackViewHeightConstraints = self.loginPasswordStackView.heightAnchor.constraint(equalToConstant: 100)
        
        let loginInButtonTopConstraints = self.loginInButton.topAnchor.constraint(equalTo: self.loginPasswordStackView.bottomAnchor, constant: 16)
        let loginInButtonLeftConstraints = self.loginInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let loginInButtonRightConstraints = self.loginInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let loginInButtonHeightConstraints = self.loginInButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
        topConstraints, leftConstraints, rightConstraints, bottomConstraints,
        contentViewTopConstraints, contentViewBottomConstraints, contentViewLeadingConstraints, contentViewTrailingConstraints, contentViewCenterXConstraints, contentViewCenterYConstraints,contentViewWidthConstraints, contentViewHeightConstraints,
        logoImageViewBottomConstraints, logoImageViewCenterXConstraints, logoImageViewWidthConstraints, logoImageViewHeightConstraints,
        loginPasswordStackViewLeftConstraints, loginPasswordStackViewRightConstraints, loginPasswordStackViewHeightConstraints, loginPasswordStackViewCenterYConstraints,
        loginInButtonTopConstraints, loginInButtonLeftConstraints, loginInButtonRightConstraints, loginInButtonHeightConstraints
        ])
    }
    
    @objc func buttonClicked() {
        let profileViewController = ProfileViewController()
        if self.loginTextField.text != "" && self.passwordTextField.text != "" {
            navigationController?.pushViewController(profileViewController, animated: true)
            //self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }

}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}