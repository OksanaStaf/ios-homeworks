//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by OksanaS on 19.03.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cat gentleman")
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 45
        imageView.layer.masksToBounds = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Cat Gentleman"
        label.textColor = .black
        label.font = UIFont(name: "Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Good Day"
        label.textColor = .gray
        label.font = UIFont(name: "Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.statusText = label.text ?? ""
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Set your status.."
        textField.backgroundColor = .white
        textField.font = UIFont(name: "Bold", size: 16)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.clearButtonMode = .unlessEditing
        textField.clearButtonMode = .always
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.text = statusLabel.text
        textField.addTarget(self, action: #selector(self.statusTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var setStatusButton : UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let srackView = UIStackView()
        srackView.axis = .vertical
        srackView.distribution = .fillEqually
        srackView.spacing = 10
        srackView.translatesAutoresizingMaskIntoConstraints = false
        return srackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let srackView = UIStackView()
        srackView.axis = .horizontal
        srackView.spacing = 16
        srackView.translatesAutoresizingMaskIntoConstraints = false
        return srackView
    }()
    
    private var buttonTopConstraint: NSLayoutConstraint?
    
    private var statusText: String?
    
    weak var delegate: ProfileHeaderViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawSelf() {
        self.addSubview(self.infoStackView)
        self.addSubview(self.setStatusButton)
        self.addSubview(self.statusTextField)
        self.infoStackView.addArrangedSubview(self.avatarImageView)
        self.infoStackView.addArrangedSubview(self.labelsStackView)
        self.labelsStackView.addArrangedSubview(self.fullNameLabel)
        self.labelsStackView.addArrangedSubview(self.statusLabel)
        
        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        
        let imageViewAspectRatio = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)
        
        let labelsStackTopConstraint =
        self.labelsStackView.topAnchor.constraint(equalTo: self.infoStackView.topAnchor)
        let labelsStackLeadingConstraint =
        self.labelsStackView.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 20)
        let labelsStackTrailingConstraint =
        self.labelsStackView.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let labelsStackHeightConstraint =
        self.labelsStackView.heightAnchor.constraint(equalToConstant: 100)
        
        let statusLabelHeight = self.statusLabel.heightAnchor.constraint(equalToConstant: 20)
        
        let statusTextFieldTopConstratint = self.statusTextField.topAnchor.constraint(equalTo: self.labelsStackView.bottomAnchor, constant: 10)
        let statusTextFieldLeadingConstraint =
        self.statusTextField.leadingAnchor.constraint(equalTo: self.labelsStackView.leadingAnchor)
        let statusTextFieldTrailingConstraint =
        self.statusTextField.trailingAnchor.constraint(equalTo: self.labelsStackView.trailingAnchor)
        let statusTextFieldHeightConstraint =
        self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
        
        
        self.buttonTopConstraint =
        self.setStatusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 20)
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
        
        let leadingButtonConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
        let trailingButtonConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let bottomButtonConstraint = self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let heightButtonConstraint = self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint,
            imageViewAspectRatio, labelsStackTopConstraint, labelsStackLeadingConstraint, labelsStackTrailingConstraint, labelsStackHeightConstraint, statusLabelHeight,
            statusTextFieldTopConstratint, statusTextFieldLeadingConstraint, statusTextFieldTrailingConstraint, statusTextFieldHeightConstraint,
            self.buttonTopConstraint, leadingButtonConstraint,
            trailingButtonConstraint, bottomButtonConstraint, heightButtonConstraint
        ].compactMap({ $0 }))
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        self.statusText = textField.text
        print("/(statusText)")
    }
    
    @objc private func buttonPressed() {
        
        statusTextField.text = nil
        setStatusButton.setTitle("Set status", for: .normal)
        
        if statusTextField.text?.isEmpty ?? true {
            self.statusTextField.backgroundColor = .systemRed
        }
    }
}
