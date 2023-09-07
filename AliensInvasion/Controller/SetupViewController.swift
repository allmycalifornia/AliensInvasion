//
//  SetupViewController.swift
//  AliensInvasion
//
//  Created by Борис Кравченко on 05.09.2023.
//

import UIKit

final class SetupViewController: UIViewController {
    
    //MARK: - Константы
    
    private enum ButtonSize {
        static let buttonWidth: CGFloat = 150
        static let buttonHeight: CGFloat = 50
        static let cornerRadiusButton: CGFloat = 10
        static let buttonFontSize: CGFloat = 40
    }
    
    private enum StepperValue {
        static let minimumValue: CGFloat = 1
        static let maximumValue: CGFloat = 10
        static let stepValue: CGFloat = 1
        static let value: CGFloat = 5
    }
    
    private enum TextLabel {
        static let nameText: String = "Enter your name"
        static let aircraftText: String = "Choose your fighter"
        static let speedAircraftText: String = "Game speed"
        static let saveText: String = "SAVE"
    }
    
    private let scrollSize: CGFloat = 100
    private let aircraftSize: CGFloat = 100
    private let stepperSize: CGFloat = 100
    private let inset: CGFloat = 8
    private let indentConstant: CGFloat = 16
    private let doubleIndentConstant: CGFloat = 32
    private let tripleIndentConstant: CGFloat = 48
    private let heightTextFieldConstant: CGFloat = 40
    private let color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    private var imageFrame: CGRect!
    private var scrollViewFrame: CGRect!
    
    let firstAircraftImage = UIImage(named: ImageName.firstAircraft.rawValue)
    let secondAircraftImage = UIImage(named: ImageName.secondAircraft.rawValue)
    let thirdAircraftImage = UIImage(named: ImageName.thirdAircraft.rawValue)
    
    //MARK: - UI
    private var myScroll = UIScrollView()
    private let nameAlert = AlertAction()
    
    private let backgroundView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "starsky")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.alpha = 0.8
        return image
    }()
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.text = TextLabel.nameText
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fighterChooseLabel: UILabel = {
        var label = UILabel()
        label.text = TextLabel.aircraftText
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stepper: UIStepper = {
        var stepper = UIStepper()
        stepper.minimumValue = StepperValue.minimumValue
        stepper.maximumValue = StepperValue.maximumValue
        stepper.stepValue = StepperValue.stepValue
        stepper.value = StepperValue.value
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.addTarget(self, action: #selector(tapStepper), for: .touchUpInside)
        stepper.backgroundColor = .white
        return stepper
    }()
    
    let speedLabel: UILabel = {
        var label = UILabel()
        label.text = TextLabel.speedAircraftText
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stepperValueLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var saveButton: UIButton = {
        var button = UIButton()
        button.setTitle(TextLabel.saveText, for: .normal)
        button.addTarget(self, action: #selector(tapSave), for: .touchUpInside)
        button.layer.cornerRadius = ButtonSize.cornerRadiusButton
        button.setTitleColor(color, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = UIFont(name: ImageName.labelGameStyle.rawValue, size: ButtonSize.buttonFontSize)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupScrollView()
        setupAircraftMenu()
        tapGestureLabelName(nameLabel)
        loadUserDefaults()
    }
    
    //MARK: - Загрузка из UserDefaults
    
    private func loadUserDefaults() {
        //let loadPhoto = UserDefaults.standard.object(forKey: Keys.imageKey.rawValue) as? String
        let result = UserDefaults.standard.value(CustomClass.self, forKey: Keys.customKey.rawValue)
        guard let result = result else { return }
        nameLabel.text = result.name
        myScroll.contentOffset.x = result.scroll
        stepperValueLabel.text = result.loadValue
        stepper.value = result.loadStepper
    }
    
    private func setupScrollView() {
        myScroll.isPagingEnabled = true
        myScroll.showsHorizontalScrollIndicator = false
        myScroll.contentSize = CGSize(width: scrollSize * 3,
                                      height: scrollSize)
        myScroll.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Gesture
    
    private func tapGestureLabelName(_ name: UILabel) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapLabel))
        name.isUserInteractionEnabled = true
        name.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapStepper(_ sender: UIStepper) {
        stepperValueLabel.text = "\(sender.value)"
    }
    
    
    @objc func tapLabel() {
        nameAlert.nameAlert(self, name: nameLabel)
    }
    
    //MARK: - Выбор самолета
    
    private func setupAircraftMenu() {
        
        imageFrame = CGRect(x: 0, y: 0,
                            width: aircraftSize,
                            height: aircraftSize)
        
        let firstAircraft = view.newImageView(paramImage: firstAircraftImage!, paramFrame: imageFrame)
        firstAircraft.isUserInteractionEnabled = true
        myScroll.addSubview(firstAircraft)
        
        imageFrame.origin.x += imageFrame.size.width
        let secondAircraft = view.newImageView(paramImage: secondAircraftImage!, paramFrame: imageFrame)
        secondAircraft.isUserInteractionEnabled = true
        myScroll.addSubview(secondAircraft)
        
        imageFrame.origin.x += imageFrame.size.width
        let thirdAircraft = view.newImageView(paramImage: thirdAircraftImage!, paramFrame: imageFrame)
        thirdAircraft.isUserInteractionEnabled = true
        myScroll.addSubview(thirdAircraft)
        
        let tapGestureFirstAircraft = UITapGestureRecognizer(target: self, action: #selector(didTapFirstAircraft(_:)))
        firstAircraft.addGestureRecognizer(tapGestureFirstAircraft)
        let tapGestureSecondAircraft = UITapGestureRecognizer(target: self, action: #selector(didTapSecondAircraft(_:)))
        secondAircraft.addGestureRecognizer(tapGestureSecondAircraft)
        let tapGestureThirdAircraft = UITapGestureRecognizer(target: self, action: #selector(didTapThirdAircraft(_:)))
        thirdAircraft.addGestureRecognizer(tapGestureThirdAircraft)
    }
    
    @objc func didTapFirstAircraft(_ gesture: UITapGestureRecognizer) {
        UserDefaults.standard.set(ImageName.firstAircraft.rawValue, forKey: Keys.aircraftKey.rawValue)
        alphaAnimateAircraft(gesture)
    }
    
    @objc func didTapSecondAircraft(_ gesture: UITapGestureRecognizer) {
        UserDefaults.standard.set(ImageName.secondAircraft.rawValue, forKey: Keys.aircraftKey.rawValue)
        alphaAnimateAircraft(gesture)
    }
    
    @objc func didTapThirdAircraft(_ gesture: UITapGestureRecognizer) {
        UserDefaults.standard.set(ImageName.thirdAircraft.rawValue, forKey: Keys.aircraftKey.rawValue)
        alphaAnimateAircraft(gesture)
    }
    //MARK: - Сохранение настроек
    
    @objc func tapSave(_ sender: UIButton) {
        let customClass = CustomClass(name: nameLabel.text ?? "", scroll: myScroll.contentOffset.x, loadValue: stepperValueLabel.text ?? "", loadStepper: stepper.value)
        UserDefaults.standard.set(encodable: customClass, forKey: Keys.customKey.rawValue)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func alphaAnimateAircraft(_ gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2) {
            gesture.view?.alpha = 0.5
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                gesture.view?.alpha = 1
            }
        }
    }
    //MARK: - Сonstraints
    func setupConstraints() {
        
        [backgroundView, fighterChooseLabel, nameLabel, stepper, myScroll, speedLabel, stepperValueLabel, saveButton].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            nameLabel.bottomAnchor.constraint(equalTo: fighterChooseLabel.topAnchor, constant: -tripleIndentConstant),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: heightTextFieldConstant),
            
            fighterChooseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fighterChooseLabel.bottomAnchor.constraint(equalTo: myScroll.topAnchor),
            
            myScroll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myScroll.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myScroll.heightAnchor.constraint(equalToConstant: scrollSize),
            myScroll.widthAnchor.constraint(equalToConstant: scrollSize),
            
            speedLabel.topAnchor.constraint(equalTo: myScroll.bottomAnchor, constant: doubleIndentConstant),
            speedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stepper.topAnchor.constraint(equalTo: speedLabel.bottomAnchor, constant: inset),
            stepper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stepper.widthAnchor.constraint(equalToConstant: stepperSize),
            
            stepperValueLabel.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: indentConstant),
            stepperValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: ButtonSize.buttonHeight),
            saveButton.widthAnchor.constraint(equalToConstant: ButtonSize.buttonWidth)
        ])
    }
}
