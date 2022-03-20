//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by OksanaS on 19.03.2022.
//

import UIKit

//protocol ProfileHeaderViewProtocol: AnyObject {
  //  func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
//}

  final class ProfileHeaderView: UIView {

    private lazy var imageView: UIImageView = { //добавила фото
       let imageView = UIImageView()
       imageView.image = UIImage(named: "cat gentleman")
       imageView.layer.borderWidth = 3.0
       imageView.layer.borderColor = UIColor.white.cgColor
       imageView.layer.cornerRadius = 60
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
          
          return label
      }()
      
      private lazy var statusButton : UIButton = {
          let button = UIButton()
          button.setTitle("Show status", for: .normal)
          button.setTitle("Set status", for: .selected)
          button.setTitleColor(.white, for: .normal)
          button.layer.cornerRadius = 12
          button.backgroundColor = .systemBlue
          button.layer.shadowColor = UIColor.black.cgColor
          button.layer.shadowOffset = CGSize(width: 4, height: 4)
          button.layer.shadowRadius = 8
          button.layer.shadowOpacity = 0.7
          button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
          button.translatesAutoresizingMaskIntoConstraints = false
          
          return button
      }()
    
    private lazy var labelsStackView: UIStackView = { //для лэйблов
        let srackView = UIStackView()
        srackView.axis = .vertical
        srackView.distribution = .fillEqually //высота кнопок одинаковая
        srackView.spacing = 10 //зазор между кнопками
        srackView.translatesAutoresizingMaskIntoConstraints = false
        
        return srackView
    }()
      
      private lazy var infoStackView: UIStackView = { //между картинкой и лейблами
          let srackView = UIStackView()
          srackView.axis = .horizontal
          srackView.spacing = 20
          srackView.translatesAutoresizingMaskIntoConstraints = false
         
          return srackView
      }()
  
    private var buttonTopConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
      
    private func drawSelf() {
        self.addSubview(self.infoStackView)
        self.addSubview(self.statusButton)
       // self.addSubview(self.textField) // для доп задачи
        self.infoStackView.addArrangedSubview(self.imageView)
        self.infoStackView.addArrangedSubview(self.labelsStackView)
        self.labelsStackView.addArrangedSubview(self.fullNameLabel)
        self.labelsStackView.addArrangedSubview(self.statusLabel)
    
        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 200)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20) //расстояние влево и право 20
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20) // ограничение правого края
        let imageViewAspectRatio = self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 1.0) //соотношение сторон у картинки задали, типа 1 к 1
        
        self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 20) //верх кнопки(написать статус где написано, привязываем к низу верхней кнопке-лейблу(в дз статус это)
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999) //делаем опциональной и выводим отдельно, тк она будет меняться при нажатии
        let leadingButtonConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor) //привязываем к левому краю стека
        let trailingButtonConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let bottomButtonConstraint = self.statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor) //задаем низ кнопки
        let heightButtonConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        
        
        NSLayoutConstraint.activate([
                    topConstraint, leadingConstraint, trailingConstraint,
                    imageViewAspectRatio,
                    self.buttonTopConstraint, leadingButtonConstraint,
                    trailingButtonConstraint, bottomButtonConstraint, heightButtonConstraint
                ].compactMap({ $0 })) // так избавляемся от опционалов(кнопка опциональна!)
    }
      @objc private func buttonPressed() {
          let status = self.statusLabel.text
          if status != nil {
           print(status!)
 }
}
}
