//
//  Aircraft.swift
//  AliensInvasion
//
//  Created by Борис Кравченко on 05.09.2023.
//

import UIKit

final class Aircraft: UIImageView {
    
    let sizeAircraft = CGSize(width: 50, height: 50)
    var aircraftCenter: CGPoint!
    
    func aircraftStep(to newCenter: CGPoint, view: UIView, boardFrames: [CGRect]) -> Bool {
        
        let newFrame = CGRect(
            origin: CGPoint(x: newCenter.x - sizeAircraft.width / 2,
                            y: newCenter.y),
            size: sizeAircraft)
        
        for boardFrame in boardFrames {
            if newFrame.intersects(boardFrame) {
                return false
            }
        }
        let viewBounds = view.safeAreaLayoutGuide.layoutFrame
        if !viewBounds.contains(newFrame) {
            return false
        }
        return true
    }
    
    func updateViewPosition() {
        UIView.animate(withDuration: 0.2) { [self] in
            self.center = aircraftCenter
        }
    }
}
