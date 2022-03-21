//
//  ProfileViewController.swift
//  Navigation
//
//  Created by OksanaS on 16.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.viewWillLayoutSubviews()

    }
  
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Моя Страница"
    }
    
    private lazy var newButton : UIButton = { //переименновала по задаче
        let button = UIButton()
        button.setTitle("Статус", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemBlue
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
       
        return button
    }()
    
   override func viewWillLayoutSubviews() {
       self.view.backgroundColor = .lightGray //цвет фона серый
       self.view.addSubview(self.profileHeaderView)
       self.view.addSubview(self.newButton)
   
          let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor) //по дефолту будет равна 0
          let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor) //левый
          let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor) // правый
          let heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
       //высоту с 400 на 220
       
       let leadingNewButtonConstraint = self.newButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor) //левый
       let trailingNewButtonConstraint = self.newButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor) // правый
       let bottomNewButtonConstraint = self.newButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
       let heightNewButtonConstraint = self.newButton.heightAnchor.constraint(equalToConstant: 50)
       
       
          NSLayoutConstraint.activate([
              topConstraint, leadingConstraint, trailingConstraint, heightConstraint, leadingNewButtonConstraint, trailingNewButtonConstraint, bottomNewButtonConstraint, heightNewButtonConstraint
          ].compactMap({ $0 }))
      }
    
   func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
       self.heightConstraint?.constant = textFieldIsVisible ? 214 : 170
            
           UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.view.layoutIfNeeded()
          } completion: { _ in
            completion()
         }
    }

}
