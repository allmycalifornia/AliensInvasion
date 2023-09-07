//
//  AlertAction.swift
//  AliensInvasion
//
//  Created by Борис Кравченко on 05.09.2023.
//

import UIKit

final class AlertAction {
    
    private let maxWordCount: Int = 20
    
    func gameOverAlert(_ view: UIViewController, score: Int, result: [Int]) {
        
        var scoreResult:[Int] = []
        
        let alertController = UIAlertController(title: "GAME OVER!",
                                                message: "Your score \(score)!",
                                                preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "Ok",
                                          style: .default) { _ in
            view.navigationController?.popViewController(animated: true)
            scoreResult = result
            scoreResult.append(score)

            UserDefaults.standard.set(scoreResult, forKey: Keys.recordKey.rawValue)
        }
        alertController.addAction(alertOkAction)
        view.present(alertController, animated: true)
    }
    
    func pauseAlert(_ view: UIViewController, animation: UIViewPropertyAnimator) {
        animation.pauseAnimation()
        
        let alertController = UIAlertController(title: "Pause!",
                                                message: "",
                                                preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "Continue",
                                          style: .default) { _ in
            alertController.dismiss(animated: true)
            animation.startAnimation()
        }
        let alertExitAction = UIAlertAction(title: "Exit",
                                            style: .destructive) { _ in
            view.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(alertOkAction)
        alertController.addAction(alertExitAction)
        view.present(alertController, animated: true)
    }
    
    func nameAlert(_ view: UIViewController, name: UILabel) {
        let alertController = UIAlertController(title: "", message: "Enter your name", preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "Ok", style: .default) { [self] _ in
            let textField = alertController.textFields?.first
            if textField?.text != "" {
                name.text = textField?.text
            } else {
                name.text = "Enter your name"
            }
            if (textField?.text!.count)! >= maxWordCount {
                name.text = ""
            }
        }
        alertController.addTextField { name in
            name.placeholder = "Your name"
        }
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .default) {_ in
            alertController.dismiss(animated: true)
        }
        
        alertController.addAction(alertOkAction)
        alertController.addAction(cancelAlertAction)
        view.present(alertController, animated: true)
    }
}
