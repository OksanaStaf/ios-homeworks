//
//  FeedViewController.swift
//  Navigation
//
//  Created by OksanaS on 16.03.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    struct Post {
        var title: String
    }
    
    let lastPost = Post.init(title: "Пост")
    
    let oneButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemMint
        button.setTitle("Первая кнопка", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapTransitionButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let twoButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemMint
        button.setTitle("Вторая кнопка", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapTransitionButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let srackView = UIStackView()
        srackView.axis = .vertical
        srackView.distribution = .fillEqually
        srackView.spacing = 10
        srackView.translatesAutoresizingMaskIntoConstraints = false
        return srackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(buttonStackView)
        self.buttonStackView.addArrangedSubview(oneButton)
        self.buttonStackView.addArrangedSubview(twoButton)
        self.setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Новостная Лента"
    }
    
    
    private func setupButtons() {
        let onePositionStackViewContraints = buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let twoPositionStackViewContraints = buttonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        let leadingOneButtonContransit = self.oneButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        let trailingOneButtonContransit = self.oneButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        
        let leadingTwoButtonContransit = self.twoButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        let trailingTwoButtonContransit = self.twoButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        
        NSLayoutConstraint.activate([
            onePositionStackViewContraints, twoPositionStackViewContraints, leadingOneButtonContransit, trailingOneButtonContransit, leadingTwoButtonContransit, trailingTwoButtonContransit
        ])
    }
    
    @objc private func didTapTransitionButton() {
        let postVC = PostViewController()
        postVC.navigationItem.title = lastPost.title
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}
