//
//  Extension + UIView.swift
//  AliensInvasion
//
//  Created by Борис Кравченко on 05.09.2023.
//

import UIKit

extension UIView {
    func gradientBoard() {
        let gradient = CAGradientLayer()
        
        let blue = UIColor(red: 200/255, green: 91/255, blue: 100/255, alpha: 1)
        let green = UIColor(red: 50/255, green: 50/255, blue: 100/255, alpha: 1)
        gradient.colors = [blue.cgColor, green.cgColor]
        gradient.locations = [0, 0.5, 1]
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.addSublayer(gradient)
    }
    
    func newImageView(paramImage: UIImage, paramFrame: CGRect) -> UIImageView {
        let result = UIImageView(frame: paramFrame)
        result.frame = paramFrame
        result.contentMode = .scaleAspectFit
        result.image = paramImage
        return result
    }
}
