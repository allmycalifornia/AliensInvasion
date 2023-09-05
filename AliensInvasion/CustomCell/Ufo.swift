//
//  Ufo.swift
//  FirstGraduateWork
//
//  Created by Кирилл Демьянцев on 14.07.2023.
//

import UIKit

class Ufo: UIImageView {
    
    private let sizeUfo = CGSize(width: 50, height: 50)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
