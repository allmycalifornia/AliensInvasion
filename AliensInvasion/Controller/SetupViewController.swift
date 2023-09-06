//
//  SetupViewController.swift
//  AliensInvasion
//
//  Created by Борис Кравченко on 05.09.2023.
//

import UIKit

final class SetupViewController: UIViewController {
    
    //MARK: - Константы
    private enum PhotoSize {
        static let photoImageSize: CGFloat = 150
        static let cornerRadiusPhoto: CGFloat = photoImageSize / 2
    }
    private enum ButtonSize {
        static let buttonWidth: CGFloat = 150
        static let buttonHeight: CGFloat = 50
        static let cornerRadiusButton: CGFloat = 10
        static let buttonFontSize: CGFloat = 20
    }
    
    private enum StepperValue {
        static let minimumValue: CGFloat = 1
        static let maximumValue: CGFloat = 10
        static let stepValue: CGFloat = 0.5
        static let value: CGFloat = 5
    }
    
    private enum TextLabel {
        static let nameText: String = "Введите имя"
        static let aircraftText: String = "Выберите самолет"
        static let avatarText: String = "Аватар"
        static let speedAircraftText: String = "Скорость самолета"
        static let saveText: String = "Сохранить"
    }
    
    private let scrollSize: CGFloat = 100
    private let aircraftSize: CGFloat = 100
    private let stepperSize: CGFloat = 100
    private let indentConstant: CGFloat = 15
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
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.text = TextLabel.nameText
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let setupLabel: UILabel = {
        var label = UILabel()
        label.text = TextLabel.aircraftText
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let photoLabel: UILabel = {
        var label = UILabel()
        label.text = TextLabel.avatarText
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var photoImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(systemName: ImageName.photoButton.rawValue)
        image.tintColor = .black
        image.layer.cornerRadius = PhotoSize.cornerRadiusPhoto
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var stepper: UIStepper = {
        var stepper = UIStepper()
        stepper.minimumValue = StepperValue.minimumValue
        stepper.maximumValue = StepperValue.maximumValue
        stepper.stepValue = StepperValue.stepValue
        stepper.value = StepperValue.value
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.addTarget(self, action: #selector(tapStepper), for: .touchUpInside)
        return stepper
    }()
    
    let speedLabel: UILabel = {
        var label = UILabel()
        label.text = TextLabel.speedAircraftText
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stepperValueLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                            size: SizeElement.labelFont.rawValue)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
        view.gradientBoard()
        setupConstraints()
        setupScrollView()
        setupAircraftMenu()
        tapGesturePhoto(photoImage)
        tapGestureLabelName(nameLabel)
        loadUserDefaults()
    }
    
    //MARK: - Загрузка из UserDefaults
    
    private func loadUserDefaults() {
        let loadPhoto = UserDefaults.standard.object(forKey: Keys.imageKey.rawValue) as? String
        let result = UserDefaults.standard.value(CustomClass.self, forKey: Keys.customKey.rawValue)
        guard let result = result else { return }
        nameLabel.text = result.name
        myScroll.contentOffset.x = result.scroll
        stepperValueLabel.text = result.loadValue
        stepper.value = result.loadStepper
        photoImage.image = loadImage(fileName: loadPhoto ?? ImageName.cloud.rawValue)
        
    }
    
    private func setupScrollView() {
        myScroll.isPagingEnabled = true
        myScroll.showsHorizontalScrollIndicator = false
        myScroll.contentSize = CGSize(width: scrollSize * 3,
                                      height: scrollSize)
        myScroll.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Gesture
    
    private func tapGesturePhoto(_ photo: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapPhoto))
        photo.isUserInteractionEnabled = true
        photo.addGestureRecognizer(tapGesture)
    }
    private func tapGestureLabelName(_ name: UILabel) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapLabel))
        name.isUserInteractionEnabled = true
        name.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapStepper(_ sender: UIStepper) {
        stepperValueLabel.text = "\(sender.value)"
    }
    
    @objc func tapPhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
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
        
        [setupLabel, photoLabel, photoImage, nameLabel, stepper, myScroll, speedLabel, stepperValueLabel, saveButton].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: indentConstant),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: heightTextFieldConstant),
            
            photoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: indentConstant),
            photoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            photoImage.topAnchor.constraint(equalTo: photoLabel.bottomAnchor),
            photoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoImage.heightAnchor.constraint(equalToConstant: PhotoSize.photoImageSize),
            photoImage.widthAnchor.constraint(equalToConstant: PhotoSize.photoImageSize),
            
            setupLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setupLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor),
            
            myScroll.topAnchor.constraint(equalTo: setupLabel.bottomAnchor, constant: indentConstant),
            myScroll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myScroll.heightAnchor.constraint(equalToConstant: scrollSize),
            myScroll.widthAnchor.constraint(equalToConstant: scrollSize),
            
            speedLabel.topAnchor.constraint(equalTo: myScroll.bottomAnchor, constant: indentConstant),
            speedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stepper.topAnchor.constraint(equalTo: speedLabel.bottomAnchor, constant: indentConstant),
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
extension SetupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            let name = saveImage(image: pickedImage)
            photoImage.image = pickedImage
            UserDefaults.standard.set(name, forKey: Keys.imageKey.rawValue)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
