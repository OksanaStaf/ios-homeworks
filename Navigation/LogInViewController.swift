//
//  LogInViewController.swift
//  Navigation
//
//  Created by OksanaS on 23.03.2022.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.setupView()
        self.tapGesture()
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbWillShow(notification: NSNotification) {
        
        if let kbFrameSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height * 0.1)
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
        }
    }
    
    @objc func kbWillHide(notification: NSNotification) {
        scrollView.contentOffset = CGPoint.zero
    }
    
    private lazy var logoVKImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Email or phone"
        textField.font = UIFont.systemFont(ofSize: 16)
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.textColor = .black
        textField.tintColor = .gray
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.clearButtonMode = .whileEditing
        textField.clearButtonMode = .unlessEditing
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Password"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.tintColor = .gray
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.clearButtonMode = .whileEditing
        textField.clearButtonMode = .unlessEditing
        textField.clearButtonMode = .always
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        let image = UIImage(named: "blue_pixel")
        button.setBackgroundImage(image, for: .normal)
        button.backgroundColor = UIColor(named: "Color")
        button.addTarget(self, action: #selector(self.didTapLogInButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите пароль, но не менее 6 символов!"
        label.textColor = .black
        label.isHidden = true
        label.font = UIFont(name: "Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var topButtonConstraint: NSLayoutConstraint?
    
    private func setupView() {
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(stackView)
        self.scrollView.addSubview(logoVKImageView)
        self.stackView.addArrangedSubview(textFieldStackView)
        self.stackView.addArrangedSubview(logInButton)
        self.textFieldStackView.addArrangedSubview(loginTextField)
        self.textFieldStackView.addArrangedSubview(passwordTextField)
        
        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let scrollViewRightConstraint = self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let scrollViewLeftConstraint = self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        
        let bottomLogoConstraint = self.logoVKImageView.bottomAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -70)
        let hightLogoConstraint = self.logoVKImageView.heightAnchor.constraint(equalToConstant: 100)
        let widthLogoConstraint = self.logoVKImageView.widthAnchor.constraint(equalToConstant: 100)
        let centerXLogoConstraint = self.logoVKImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        
        let stackViewCenterXConstraint = self.stackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let stackViewCenterYConstraint = self.stackView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor)
        let stackViewLeadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16)
        let stackViewTrailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16)
        
        let loginTextFieldHeightAnchor = self.loginTextField.heightAnchor.constraint(equalToConstant: 50)
        let passwordTextFieldHeightAnchor = self.passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        
        self.topButtonConstraint = self.logInButton.topAnchor.constraint(equalTo: self.textFieldStackView.bottomAnchor, constant: 16)
        self.topButtonConstraint?.priority = UILayoutPriority(rawValue: 999)
        let buttonLeadingConstraint = self.logInButton.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16)
        let buttonTrailingConstraint = self.logInButton.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16)
        
        let heightButtonConstraint = self.logInButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
            scrollViewTopConstraint, scrollViewRightConstraint, scrollViewBottomConstraint, scrollViewLeftConstraint, bottomLogoConstraint, hightLogoConstraint, widthLogoConstraint, centerXLogoConstraint, stackViewCenterXConstraint, stackViewCenterYConstraint, stackViewLeadingConstraint, stackViewTrailingConstraint, loginTextFieldHeightAnchor, passwordTextFieldHeightAnchor, self.topButtonConstraint, buttonLeadingConstraint, buttonTrailingConstraint, heightButtonConstraint
        ].compactMap( {$0} ))
        
    }
    
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func validatePassword(userPassword: String) -> Bool {
        if userPassword.count < 6 {
            print("Не соотвествует количеству")
            return false
        }
        return true
    }
    func validateEmail(email: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @objc private func didTapLogInButton() {
        if logInButton.isSelected {
            logInButton.alpha = 0.8
        } else if logInButton.isHighlighted {
            logInButton.alpha = 0.8
        } else if !logInButton.isEnabled {
            logInButton.alpha = 0.8
        } else {
            logInButton.alpha = 1
        }
        
        
        let topLabelConstraint = self.warningLabel.topAnchor.constraint(equalTo: self.textFieldStackView.bottomAnchor, constant: -10)
        let leadingLabelConstraint = self.warningLabel.leadingAnchor.constraint(equalTo: self.textFieldStackView.leadingAnchor)
        let heightLabelConstraint = self.warningLabel.heightAnchor.constraint(equalToConstant: 40)
        let trailingLabelConstraint = self.warningLabel.trailingAnchor.constraint(equalTo: self.textFieldStackView.trailingAnchor)
        
        self.topButtonConstraint = self.logInButton.topAnchor.constraint(equalTo: self.warningLabel.bottomAnchor, constant: 16)
        
        
        let password = validatePassword(userPassword: passwordTextField.text!)
        if(password == false) {
            self.warningLabel.isHidden = false
            self.scrollView.addSubview(self.warningLabel)
            self.topButtonConstraint?.isActive = false
            
            NSLayoutConstraint.activate([topLabelConstraint, leadingLabelConstraint, trailingLabelConstraint, heightLabelConstraint, topButtonConstraint].compactMap( {$0} ))
        } else {
            self.warningLabel.removeFromSuperview()
            NSLayoutConstraint.deactivate([ topLabelConstraint, leadingLabelConstraint, trailingLabelConstraint, heightLabelConstraint
                                          ].compactMap( {$0} ))
            self.warningLabel.isHidden = true
        }
        
        if loginTextField.text?.isEmpty ?? true {
            self.loginTextField.backgroundColor = .systemRed
        }
        
        if passwordTextField.text?.isEmpty ?? true {
            self.passwordTextField.backgroundColor = .systemRed
        }
        
        if self.loginTextField.text == "oksanaStafeeva@yandex.ru" && passwordTextField.text == "123456789" {
            
            let profileVC = ProfileViewController()
            self.navigationController?.pushViewController(profileVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Внимание!", message: "Введите логин или пароль еще раз.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
