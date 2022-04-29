//
//  OpenPhotoCell.swift
//  Navigation
//
//  Created by OksanaS on 29.04.2022.
//

import UIKit

protocol OpenImageDelegate: AnyObject {
    func pressedButton(view: OpenPhotoCell)
}

class OpenPhotoCell: UIView {
        weak var delegate: OpenImageDelegate?
        var pressButtonCancel = UITapGestureRecognizer()

        lazy var imageOpenCell: UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.clipsToBounds = true
            image.backgroundColor = .black
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()

        lazy var buttonExit: UIImageView = {
            let button = UIImageView()
            button.image = UIImage(systemName: "pip.exit")
            button.tintColor = .white
            button.alpha = 0
            button.isUserInteractionEnabled = true
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.translatesAutoresizingMaskIntoConstraints = false
            drawSelf()
            setupGesture()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func drawSelf() {
            self.addSubview(imageOpenCell)
            self.addSubview(buttonExit)

            NSLayoutConstraint.activate([
                imageOpenCell.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                imageOpenCell.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                imageOpenCell.widthAnchor.constraint(equalTo: self.widthAnchor),
                imageOpenCell.heightAnchor.constraint(equalTo: self.widthAnchor),
                buttonExit.topAnchor.constraint(equalTo: self.topAnchor, constant: 110),
                buttonExit.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                buttonExit.widthAnchor.constraint(equalToConstant: 30),
                buttonExit.heightAnchor.constraint(equalToConstant: 30)
            ])
        }

        private func setupGesture() {
            pressButtonCancel.addTarget(self, action: #selector(pressedButton(_:)))
            buttonExit.addGestureRecognizer(pressButtonCancel)
        }

        @objc func pressedButton(_ gestureRecognizer: UITapGestureRecognizer) {
            delegate?.pressedButton(view: self)
        }
    }
