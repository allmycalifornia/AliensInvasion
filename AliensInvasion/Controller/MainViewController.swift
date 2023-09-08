//
//  MainViewController.swift
//  AliensInvasion
//
//  Created by Борис Кравченко on 05.09.2023.
//

import UIKit

final class MainViewController: UIViewController {

    let setupController = SetupViewController()
    let recordViewController = RecordsViewController()
    let rulesViewController = RulesViewController()
    
    private let backgroundView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "starsky")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.alpha = 0.8
        return image
    }()
    
    let labelGame: UILabel = {
        var label = UILabel()
        label.text = ImageName.nameGame.rawValue
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelTitleFont.rawValue)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelStart: UILabel = {
        var label = UILabel()
        label.text = "Start the game"
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelSettings: UILabel = {
        var label = UILabel()
        label.text = "Settings"
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelResults: UILabel = {
        var label = UILabel()
        label.text = "Results table"
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelRules: UILabel = {
        var label = UILabel()
        label.text = "Rules"
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()

    lazy var startGameButton: UIButton = {
       var button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: SizeElement.sizeEntryButton.rawValue,
                                                      weight: .medium,
                                                      scale: .large)
        let largeBoldDoc = UIImage(named: ImageName.entryButtonImage.rawValue)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapEntryGame), for: .touchUpInside)
        return button
    }()

    lazy var settingsGameButton: UIButton = {
       var button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: SizeElement.sizeSetupButton.rawValue,
                                                      weight: .medium,
                                                      scale: .large)
        let largeBoldDoc = UIImage(named: ImageName.setupButtonImage.rawValue)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapSetupGame), for: .touchUpInside)
        return button
    }()
    
    lazy var recordTableViewButton: UIButton = {
       var button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: SizeElement.sizeSetupButton.rawValue,
                                                      weight: .medium,
                                                      scale: .large)
        let largeBoldDoc = UIImage(named: ImageName.recordTableImage.rawValue)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapRecordGame), for: .touchUpInside)
        return button
    }()
    
    lazy var rulesButton: UIButton = {
       var button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: SizeElement.sizeSetupButton.rawValue,
                                                      weight: .medium,
                                                      scale: .large)
        let largeBoldDoc = UIImage(named: ImageName.rulesImage.rawValue)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapRulesGame), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        setupConstraints()
    }
    
    @objc private func tapEntryGame() {
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
    
    @objc private func tapSetupGame() {
        navigationController?.pushViewController(SetupViewController(), animated: true)
    }
    
    @objc private func tapRecordGame() {
        navigationController?.pushViewController(recordViewController, animated: true)
    }
    
    @objc private func tapRulesGame() {
        navigationController?.present(rulesViewController, animated: true)
    }
    
    //MARK: - Сonstraints
    private func setupConstraints() {
        
        [backgroundView, labelGame, labelStart, labelSettings, labelRules, labelResults, startGameButton, settingsGameButton, recordTableViewButton, rulesButton].forEach {
            view.addSubview($0)
        }
        
        let size: CGFloat = 60
        let inset: CGFloat = 8
        let doubleInset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            labelGame.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startGameButton.topAnchor.constraint(equalTo: labelGame.bottomAnchor, constant: size),
            startGameButton.widthAnchor.constraint(equalToConstant: size),
            startGameButton.heightAnchor.constraint(equalToConstant: size),
            
            labelStart.topAnchor.constraint(equalTo: startGameButton.bottomAnchor, constant: inset),
            labelStart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            settingsGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsGameButton.topAnchor.constraint(equalTo: labelStart.bottomAnchor, constant: doubleInset),
            settingsGameButton.widthAnchor.constraint(equalToConstant: size),
            settingsGameButton.heightAnchor.constraint(equalToConstant: size),
            
            labelSettings.topAnchor.constraint(equalTo: settingsGameButton.bottomAnchor, constant: inset),
            labelSettings.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            recordTableViewButton.topAnchor.constraint(equalTo: settingsGameButton.bottomAnchor, constant: size),
            recordTableViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordTableViewButton.widthAnchor.constraint(equalToConstant: size),
            recordTableViewButton.heightAnchor.constraint(equalToConstant: size),
            
            labelResults.topAnchor.constraint(equalTo: recordTableViewButton.bottomAnchor, constant: inset),
            labelResults.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rulesButton.topAnchor.constraint(equalTo: recordTableViewButton.bottomAnchor, constant: size),
            rulesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rulesButton.widthAnchor.constraint(equalToConstant: size),
            rulesButton.heightAnchor.constraint(equalToConstant: size),
            
            labelRules.topAnchor.constraint(equalTo: rulesButton.bottomAnchor, constant: inset),
            labelRules.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
