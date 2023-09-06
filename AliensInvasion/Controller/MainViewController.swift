//
//  MainViewController.swift
//  AliensInvasion
//
//  Created by Борис Кравченко on 05.09.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private enum SizeElement: CGFloat {
        case labelFont = 30
        case sizeEntryButton = 60
        case sizeSetupButton = 32
    }

    let setupController = SetupViewController()
    let recordViewController = RecordsViewController()
    
    let labelGame: UILabel = {
        var label = UILabel()
        label.text = ImageName.nameGame.rawValue
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelStart: UILabel = {
        var label = UILabel()
        label.text = "Start the game"
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelSettings: UILabel = {
        var label = UILabel()
        label.text = "Settings"
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelResults: UILabel = {
        var label = UILabel()
        label.text = "Results table"
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var entryGameButton: UIButton = {
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

    lazy var setupGameButton: UIButton = {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.gradientBoard()
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
    
    //MARK: - Сonstraints
    private func setupConstraints() {
        
        [labelGame, labelStart, labelSettings, labelResults, entryGameButton, setupGameButton, recordTableViewButton].forEach {
            view.addSubview($0)
        }
        
        let size: CGFloat = 75
        let inset: CGFloat = 8
        let insetElement: CGFloat = 75
        
        NSLayoutConstraint.activate([
            
            labelGame.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            entryGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            entryGameButton.bottomAnchor.constraint(equalTo: setupGameButton.topAnchor, constant: -insetElement),
            entryGameButton.widthAnchor.constraint(equalToConstant: size),
            entryGameButton.heightAnchor.constraint(equalToConstant: size),
            
            labelStart.topAnchor.constraint(equalTo: entryGameButton.bottomAnchor, constant: inset),
            labelStart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            setupGameButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            setupGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setupGameButton.widthAnchor.constraint(equalToConstant: size),
            setupGameButton.heightAnchor.constraint(equalToConstant: size),
            
            labelSettings.topAnchor.constraint(equalTo: setupGameButton.bottomAnchor, constant: inset),
            labelSettings.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            recordTableViewButton.topAnchor.constraint(equalTo: setupGameButton.bottomAnchor, constant: insetElement),
            recordTableViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordTableViewButton.widthAnchor.constraint(equalToConstant: size),
            recordTableViewButton.heightAnchor.constraint(equalToConstant: size),
            
            labelResults.topAnchor.constraint(equalTo: recordTableViewButton.bottomAnchor, constant: inset),
            labelResults.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
