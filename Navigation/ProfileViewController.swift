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
    
   override func viewWillLayoutSubviews() {
       self.view.backgroundColor = .lightGray //цвет фона серый
       self.view.addSubview(self.profileHeaderView)
   
          let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor) //по дефолту будет равна 0
          let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor) //левый
          let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor) // правый
          let heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 400) //высота
          
          NSLayoutConstraint.activate([
              topConstraint, leadingConstraint, trailingConstraint, heightConstraint
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
