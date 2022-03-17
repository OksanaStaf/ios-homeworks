//
//  PostViewController.swift
//  Navigation
//
//  Created by OksanaS on 16.03.2022.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemTeal
        
        let myButton = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill"), style: .plain, target: self, action: #selector(didTapButton))
        
        self.navigationItem.rightBarButtonItem = myButton
    }
    @objc func didTapButton() {
    let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .fullScreen
        self.present(infoVC, animated: true)
    }
}
