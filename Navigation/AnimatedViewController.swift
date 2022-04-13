//
//  AnimatedViewController.swift
//  Navigation
//
//  Created by OksanaS on 02.04.2022.
//

import UIKit

final class AnimatedViewController: UIViewController {
    
    private lazy var avatarImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cat gentleman")
        imageView.layer.borderWidth = 3.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 65
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private lazy var backView: UIView = {
        
        let view = UIView()
        view.alpha = 0 //задаем прозрачность
        view.isHidden = true
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var exitButton: UIButton = {
        
        let button = UIButton()
        let image = UIImage(systemName: "multiply.circle")
        button.setBackgroundImage(image, for: .normal)
        button.isHidden = true
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private let tapGestureRecognizer = UITapGestureRecognizer()
    
    private var topAvatarImageView: NSLayoutConstraint?
    private var leadingAvatarImageView: NSLayoutConstraint?
    private var heightAvatarImageView: NSLayoutConstraint?
    private var widthAvatarImageView: NSLayoutConstraint? //выносим констрейнты
    
    private var isExpanded = false //расширеное вью или нет
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupGesture()
    }
    
    private func setupView() {
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.avatarImageView)
        self.view.addSubview(self.backView)
        self.view.addSubview(self.exitButton)
        self.view.bringSubviewToFront(self.avatarImageView)//на передний план
        
        self.topAvatarImageView = self.avatarImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50)
        self.leadingAvatarImageView = self.avatarImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        self.heightAvatarImageView = self.avatarImageView.heightAnchor.constraint(equalToConstant: 140)
        self.widthAvatarImageView = self.avatarImageView.widthAnchor.constraint(equalToConstant: 140)
        
        let centerXViewConstraint = self.backView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let centerYViewConstraint = self.backView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let widthViewConstraint = self.backView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        let heightViewConstraint = self.backView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        
        let topExitButtonConstraint = self.exitButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50)
        let rightExitButtonConstraint = self.exitButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let heightExitButtonConstraint = self.exitButton.heightAnchor.constraint(equalToConstant: 45)
        let widthExitButtonConstraint = self.exitButton.widthAnchor.constraint(equalToConstant: 45)
        
        NSLayoutConstraint.activate([ self.topAvatarImageView, self.leadingAvatarImageView,  self.heightAvatarImageView, self.widthAvatarImageView, centerXViewConstraint, centerYViewConstraint,  widthViewConstraint, heightViewConstraint, topExitButtonConstraint,  rightExitButtonConstraint, heightExitButtonConstraint, widthExitButtonConstraint].compactMap({ $0 }))
        
    }
    
    private func setupGesture() { //описываем ее действие
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.handleTapGesture(_:))) //вызываем селектор
        self.avatarImageView.addGestureRecognizer(self.tapGestureRecognizer) //наше вью может обрабатывать эту анимацию
        exitButton.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
    }
    
    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) { //реализовываем handleTapGesture
        guard self.tapGestureRecognizer === gestureRecognizer else { return } //сравниваем ссылочные объекты по ссылке
        self.backView.isHidden = false
        self.exitButton.isHidden = false
        self.isExpanded.toggle()
        self.widthAvatarImageView?.constant = self.isExpanded ? self.view.bounds.width : 140
        self.heightAvatarImageView?.constant = self.isExpanded ? self.view.bounds.height : 140
        NSLayoutConstraint.deactivate([ self.topAvatarImageView, self.leadingAvatarImageView
                                      ].compactMap( {$0} ))
        
        
        UIView.animate(withDuration: 0.5) {
            self.backView.alpha = self.isExpanded ? 0.5 : 0
            self.view.layoutIfNeeded()
            
        } completion: { _ in
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.exitButton.alpha = self.isExpanded ? 1 : 0
            self.view.layoutIfNeeded()
            
        } completion: { _ in
        }
    }
    
    @objc private func didTapButton() {
        self.backView.isHidden = false
        self.exitButton.isHidden = false
        self.isExpanded.toggle()
        self.heightAvatarImageView?.constant = self.isExpanded ? self.view.bounds.height : 140 //300 : 140
        self.widthAvatarImageView?.constant = self.isExpanded ? self.view.bounds.height : 140
        NSLayoutConstraint.activate([ self.topAvatarImageView, self.leadingAvatarImageView
                                    ].compactMap( {$0} ))
        UIView.animate(withDuration: 0.5) {
            self.backView.alpha = self.isExpanded ? 0.5 : 0
            self.view.layoutIfNeeded()
            
        } completion: { _ in
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.exitButton.alpha = self.isExpanded ? 1 : 0
            self.view.layoutIfNeeded()
            
        } completion: { _ in
        }
        
    }
}
