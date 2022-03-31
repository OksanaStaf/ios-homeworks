//
//  Setable.swift
//  Navigation
//
//  Created by OksanaS on 30.03.2022.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel:ViewModelProtocol)
    
}
