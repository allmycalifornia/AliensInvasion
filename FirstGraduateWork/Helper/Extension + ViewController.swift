//
//  Extension + ViewController.swift
//  AliensInvasion
//
//  Created by Борис Кравченко on 05.09.2023.
//

import UIKit

extension GameViewController {
    func setupBoardView(frame: CGRect) -> UIView {
        let boardView = UIView()
        boardView.frame = frame
        view.gradientBoard()
        return boardView
    }
}
