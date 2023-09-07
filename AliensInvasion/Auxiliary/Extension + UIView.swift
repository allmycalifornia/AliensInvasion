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
        
        let violet = UIColor(red: 0/255, green: 86/255, blue: 186/255, alpha: 1.0)
        let black = UIColor(red: 0/255, green: 14/255, blue: 48/255, alpha: 1.0)
        gradient.colors = [violet.cgColor, black.cgColor]
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
