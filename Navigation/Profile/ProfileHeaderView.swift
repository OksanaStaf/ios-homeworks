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

  final class ProfileHeaderView: UIView {

    private lazy var avatarImageView: UIImageView = { //переимен. по задаче
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
      
      private lazy var fullNameLabel: UILabel = { //переимен. по задаче
          let label = UILabel()
          label.text = "Cat Gentleman"
          label.textColor = .black
          label.font = UIFont(name: "Bold", size: 18) 
          label.translatesAutoresizingMaskIntoConstraints = false
          //где фиолетовый восклицательный знак: lfullNameLabel.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
          return label
      }()
      
      private lazy var statusLabel: UILabel = { //переимен. по задаче
          let label = UILabel()
          label.text = "Good Day"
          label.textColor = .gray
          label.font = UIFont(name: "Regular", size: 14)
// где фиолетовый восклицательный знак: statusLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
//и на сжатие: statusLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
          label.translatesAutoresizingMaskIntoConstraints = false
          
          return label
      }()
      
      private lazy var statusTextField: UITextField = {
          let textField = UITextField()
          textField.isHidden = true //скрытая кнопка
          textField.backgroundColor = .systemMint
          textField.font = UIFont(name: "Bold", size: 16)
          textField.textColor = .white
          textField.layer.cornerRadius = 12
          textField.layer.borderWidth = 1
          textField.layer.borderColor = UIColor.white.cgColor
          textField.textAlignment = .center
          textField.clearButtonMode = .whileEditing
          textField.clearButtonMode = .unlessEditing
          let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
          textField.leftView = leftView
          textField.clearButtonMode = .always
          textField.translatesAutoresizingMaskIntoConstraints = false
          
          return textField
      }()
      
      private lazy var setStatusButton : UIButton = { //переименновала по задаче
          let button = UIButton()
          button.setTitle("Show status", for: .normal)
          button.setTitle("Set status", for: .selected)
          button.setTitleColor(.white, for: .normal)
          button.layer.cornerRadius = 12
          button.backgroundColor = .systemBlue
          button.addTarget(self, action: #selector(self.didTapStatusButton), for: .touchUpInside)
          button.translatesAutoresizingMaskIntoConstraints = false
          // button.addTarget(self, action: #selector(self.statusTextChanged), for: .editingChanged)
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
  
   // private var statusText: String
      
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
        self.addSubview(self.setStatusButton)
        //self.addSubview(self.statusTextField)
        self.infoStackView.addArrangedSubview(self.avatarImageView)
        self.infoStackView.addArrangedSubview(self.labelsStackView)
        self.labelsStackView.addArrangedSubview(self.fullNameLabel)
        self.labelsStackView.addArrangedSubview(self.statusLabel)
       // self.labelsStackView.addArrangedSubview(self.statusTextField)
    
        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20) //расстояние влево и право 20
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20) // ограничение правого края
        let imageViewAspectRatio = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0) //соотношение сторон у картинки задали, типа 1 к 1
        
        self.buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 20) //верх кнопки(написать статус где написано, привязываем к низу верхней кнопке-лейблу
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999) //делаем опциональной и выводим отдельно, тк она будет меняться при нажатии
        let leadingButtonConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor) //привязываем к левому краю стека
        let trailingButtonConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let bottomButtonConstraint = self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor) //задаем низ кнопки
        let heightButtonConstraint = self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        
        
        NSLayoutConstraint.activate([
                    topConstraint, leadingConstraint, trailingConstraint,
                    imageViewAspectRatio,
                    self.buttonTopConstraint, leadingButtonConstraint,
                    trailingButtonConstraint, bottomButtonConstraint, heightButtonConstraint
                ].compactMap({ $0 })) // так избавляемся от опционалов(кнопка опциональна!)
    }
      
     @objc private func didTapStatusButton() {
         let status = self.statusLabel.text
             if status != nil {
          print(status!)
         }
     }
      
     // @objc private func statusTextChanged() {
         
    // }
     
      /*
       @objc private func statusTextChanged() {
           var statusText = textFiled {
           print(statusText)
       
    self.buttonTopConstraint?.isActive = false // Необходимо деактивировать констрейнт, иначе будет конфликт констрейнтов, и Auto Layout не сможет однозначно определить фреймы textField'а.
                 
    let topConstraint = self.textField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 10)
    let leadingConstraint = self.textField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor)
    let trailingConstraint = self.textField.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
    let heightTextFieldConstraint = self.textField.heightAnchor.constraint(equalToConstant: 34)
    self.buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20)
                 
                 NSLayoutConstraint.activate([
                     topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint, self.buttonTopConstraint
                 ].compactMap({ $0 }))
             }
        //  self.delegate?.didTapStatusButton(textFieldIsVisible: self.textField.isHidden) { [weak self] in
            //          self?.textField.isHidden.toggle()
             //     }

}
*/
  }
