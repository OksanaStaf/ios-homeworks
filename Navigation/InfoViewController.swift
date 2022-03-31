//
//  InfoViewController.swift
//  Navigation
//
//  Created by OksanaS on 17.03.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        self.view.addSubview(alertButton)
        self.setupButton()
    }
    
    let alertButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.setTitle("Оповещение", for: .normal)
        button.setTitleColor( .black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupButton() {
        alertButton.addTarget(self, action: #selector(didTapAlertButton), for: .touchUpInside)
        self.alertButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.alertButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.alertButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.alertButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc private func didTapAlertButton() {
        let alert = UIAlertController(title: "Выйти?", message: "Вы согласны?", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Да", style: .default, handler: {action in print ("Да")})
        let noButton = UIAlertAction(title: "Нет", style: .default, handler: {action in print ("Нет")})
        alert.addAction(yesButton)
        alert.addAction(noButton)
        present (alert, animated: true, completion: nil)
    }
}
