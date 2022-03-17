//
//  ProfileViewController.swift
//  Navigation
//
//  Created by OksanaS on 16.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.viewDidLoad()
        self.view.backgroundColor = .systemMint
        self.setupNavigationBar()
        // self.setupView()
    }
  
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Моя Страница"
    }
}
