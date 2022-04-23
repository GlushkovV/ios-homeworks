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
    
    private lazy var invalidLabel: UILabel = {
        let label = UILabel()
        label.text = "Не корректный логин или пароль"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(loginInButton)
        contentView.addSubview(loginPasswordStackView)
        contentView.addSubview(invalidLabel)
        loginPasswordStackView.addArrangedSubview(loginTextField)
        loginPasswordStackView.addArrangedSubview(passwordTextField)
        self.setupConstraints()
        self.hidingKeyboard()
        self.navigationController?.navigationBar.isHidden = true
        let notificationCenterKeyboard = NotificationCenter.default
        notificationCenterKeyboard.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenterKeyboard.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        alertInvalidAuthorization()

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
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            logoImageView.bottomAnchor.constraint(equalTo: loginPasswordStackView.topAnchor, constant: -120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 1.0),
            
            loginPasswordStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            loginPasswordStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginPasswordStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginPasswordStackView.heightAnchor.constraint(equalToConstant: 100),
            
            loginInButton.topAnchor.constraint(equalTo: loginPasswordStackView.bottomAnchor, constant: 16),
            loginInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginInButton.heightAnchor.constraint(equalToConstant: 50),
            
            invalidLabel.topAnchor.constraint(equalTo: loginInButton.bottomAnchor, constant: 4),
            invalidLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            invalidLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
         
    @objc func buttonClicked() {
        if self.loginTextField.text == AuthorizationData().defaultLogin && self.passwordTextField.text == AuthorizationData().defaultPassword {
            invalidLabel.isHidden = true
            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        } else {
            authorizationEmptyError(textField: loginTextField)
            authorizationEmptyError(textField: passwordTextField)
            authorizationError()
        }
    }
    
    private func authorizationEmptyError(textField: UITextField) {
        if textField.text == "" {
            textField.shake()
        }
    }
    
    private func authorizationError() {
        guard let login = loginTextField.text else { return }
        if isValidEmail(login) {
            guard let password = passwordTextField.text else { return }
            if password.count > 0 && password.count < 8 {
                invalidLabel.text = AuthorizationData().invalidPassword
                invalidLabel.shake()
                invalidLabel.isHidden = false
            } else {
                if password.count >= 8 {
                    invalidLabel.text = AuthorizationData().invalidLogPass
                    invalidLabel.shake()
                    invalidLabel.isHidden = false
                    alertInvalidAuthorization()
                } else {
                invalidLabel.isHidden = true
                }
            }
        } else {
            if login != "" {
                invalidLabel.text = AuthorizationData().invalidLogin
                invalidLabel.shake()
                invalidLabel.isHidden = false
            } else {
                invalidLabel.isHidden = true
            }
        }
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func alertInvalidAuthorization() {
        let alert = UIAlertController(title: "Тесовые данные:", message: "Login: \(AuthorizationData().defaultLogin) \nPassword: \(AuthorizationData().defaultPassword)", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Заполнить", style: .default) { action in
                self.loginTextField.text = AuthorizationData().defaultLogin
                self.passwordTextField.text = AuthorizationData().defaultPassword
                self.invalidLabel.isHidden = true
            }
        let cancelButton = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
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

public extension UIView {

    func shake(count : Float = 4,for duration : TimeInterval = 0.3,withTranslation translation : Float = 4) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}
