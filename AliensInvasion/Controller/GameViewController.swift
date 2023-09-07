//
//  GameViewController.swift
//  AliensInvasion
//
//  Created by Борис Кравченко on 05.09.2023.
//

import UIKit

final class GameViewController: UIViewController {
    
    //MARK: - Константы
    private let sizeUfo = CGSize(width: 50, height: 50)
    private let sizeScoreCounter = CGSize(width: 100, height: 100)
    private let heightMountain: CGFloat = 90
    private let mountainStep: CGFloat = 200
    private let mountainCount: Int = 3
    private var boardFrames: [CGRect] = []
    
    private var ufoImage: UIImageView!
    private var leftElementImage: UIImageView!
    private var rightElementImage: UIImageView!
    private var leftBoard: UIView!
    private var rightBoard: UIView!
    private var centralBoard: UIView!
    private var scoreCounter: UILabel!
    private var stopGameButton: UIButton!
    private let customAlert = AlertAction()
    private var aircraft = Aircraft()
    private var cloud = Cloud()
    var animator = UIViewPropertyAnimator()
    
    private var leftCurrentY: CGFloat = 0
    private var rightCurrentY: CGFloat = 0
    private var speedGame = Double()
    private var score: Int = 0
    
    var resultScoreArray: [Int] = []
    var timer: Timer!
    
    private var randomXCoordinate: CGFloat {
        CGFloat.random(in: leftBoard.frame.maxX...rightBoard.frame.minX - sizeUfo.width)
    }
    
    private let ufoArray: [String] = [ImageName.ufo1.rawValue,
                                      ImageName.ufo2.rawValue,
                                      ImageName.ufo3.rawValue,
                                      ImageName.ufo4.rawValue,
                                      ImageName.ufo5.rawValue,
                                      ImageName.ufo6.rawValue,
                                      ImageName.ufo7.rawValue,
                                      ImageName.ufo8.rawValue,
                                      ImageName.ufo9.rawValue,
                                      ImageName.ufo10.rawValue,
                                      ImageName.ufo11.rawValue,
                                      ImageName.ufo12.rawValue,
                                      ImageName.ufo13.rawValue,
                                      ImageName.ufo14.rawValue,
                                      ImageName.ufo15.rawValue,
                                      ImageName.ufo16.rawValue,
                                      ImageName.ufo17.rawValue,
                                      ImageName.ufo18.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupBoardView()
        setupCloud()
        setupAircraft()
        addPanGesture(aircraft: aircraft)
        setupScoreCounter()
        addTapPauseGame(label: scoreCounter)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackgroundBoard()
        loadUserDefaults()
        setupUfo()
        timer = .scheduledTimer(timeInterval: 0.1,
                                target: self,
                                selector: #selector(ufoIntersects),
                                userInfo: nil,
                                repeats: true)
    }
    
    //MARK: - Загрузка данных из UserDefaults
    
    private func loadUserDefaults() {
        
        let aircraft = UserDefaults.standard.object(forKey: Keys.aircraftKey.rawValue) as? String
        if let aircraft = aircraft {
            self.aircraft.image = UIImage(named: aircraft)
        }
        
        let result = UserDefaults.standard.value(CustomClass.self, forKey: Keys.customKey.rawValue)
        guard let result = result else { return }
        speedGame = result.loadStepper
        
        let recordScore = UserDefaults.standard.object(forKey: Keys.recordKey.rawValue) as? [Int]
        guard let record = recordScore else { return }
        resultScoreArray = record
    }
    
    //MARK: - Жесты
    
    private func addPanGesture(aircraft: UIImageView) {
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(tap(sender:)))
        aircraft.isUserInteractionEnabled = true
        aircraft.addGestureRecognizer(panGesture)
    }
    
    private func addTapPauseGame(label: UILabel) {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(pauseGame))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
    }
    
    private func moveViewPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let new = CGPoint(x: view.center.x + translation.x,
                          y: view.center.y)
        
        if aircraft.aircraftStep(to: new, view: self.view, boardFrames: boardFrames) {
            aircraft.aircraftCenter = new
            aircraft.updateViewPosition()
        }
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    //MARK: - Настройка Boards
    func setupBackgroundBoard() {
        let backgroundLeftBoardUp = UIImageView(image: UIImage(named: ImageName.galaxy.rawValue))
        backgroundLeftBoardUp.frame = CGRect(x: view.frame.origin.x,
                                             y: 0,
                                             width: leftBoard.bounds.width,
                                             height: view.frame.height)
        leftBoard.addSubview(backgroundLeftBoardUp)
        
        let backgroundLeftBoardDown = UIImageView(image: UIImage(named: ImageName.galaxy.rawValue))
        backgroundLeftBoardDown.frame = CGRect(x: view.frame.origin.x,
                                               y: -view.frame.size.height,
                                               width: leftBoard.bounds.width,
                                               height: view.frame.height)
        leftBoard.addSubview(backgroundLeftBoardDown)
        animateBoards(firstImage: backgroundLeftBoardUp, secondImage: backgroundLeftBoardDown)
        
        let backgroundRightBoardUp = UIImageView(image: UIImage(named: ImageName.galaxy.rawValue))
        backgroundRightBoardUp.frame = CGRect(x: view.frame.origin.x,
                                              y: 0,
                                              width: rightBoard.bounds.width,
                                              height: view.frame.height)
        rightBoard.addSubview(backgroundRightBoardUp)
        
        let backgroundRightBoardDown = UIImageView(image: UIImage(named: ImageName.galaxy.rawValue))
        backgroundRightBoardDown.frame = CGRect(x: view.frame.origin.x,
                                                y: -view.frame.size.height,
                                                width: rightBoard.bounds.width,
                                                height: view.frame.height)
        rightBoard.addSubview(backgroundRightBoardDown)
        
        animateBoards(firstImage: backgroundRightBoardUp, secondImage: backgroundRightBoardDown)
    }
    
    private func animateBoards(firstImage: UIImageView, secondImage: UIImageView) {
        UIView.animate(withDuration: speedGame,
                       delay: 0,
                       options: [.curveLinear],
                       animations: {
            firstImage.frame = firstImage.frame.offsetBy(dx: 0,
                                                         dy: self.view.frame.height)
            secondImage.frame = secondImage.frame.offsetBy(dx: 0,
                                                           dy: self.view.frame.height)
        }) { [self] _ in
            firstImage.frame = CGRect(x: view.frame.origin.x,
                                      y: 0,
                                      width: rightBoard.bounds.width,
                                      height: view.frame.height)
            secondImage.frame = CGRect(x: view.frame.origin.x,
                                       y: -view.frame.size.height,
                                       width: rightBoard.bounds.width,
                                       height: view.frame.height)
            animateBoards(firstImage: firstImage, secondImage: secondImage)
        }
    }
    //MARK: - Настройка левого, центрального, правого борта
    private func setupBoardView() {
        
        let widthSize: CGFloat = 120
        let boardSize = CGSize(width: view.bounds.width / 2 - widthSize,
                               height: view.bounds.height)
        let centralBoardSize = CGSize(width: view.bounds.width - boardSize.width * 2,
                                      height: view.bounds.height)
        
        leftBoard = setupBoardView(frame: CGRect(origin: CGPoint(x: view.bounds.origin.x,
                                                                 y: view.bounds.origin.y),
                                                 size: boardSize))
        rightBoard = setupBoardView(frame: CGRect(origin: CGPoint(x: view.bounds.origin.x + view.bounds.width - boardSize.width,
                                                                  y: view.bounds.origin.y),
                                                  size: boardSize))
        centralBoard = setupBoardView(frame: CGRect(origin: CGPoint(x: leftBoard.frame.maxX,
                                                                    y: view.bounds.origin.y),
                                                    size: centralBoardSize))
        boardFrames = [leftBoard.frame, rightBoard.frame]
        
        [leftBoard, centralBoard, rightBoard].forEach {
            view.addSubview($0)
        }
    }
    
    //MARK: - Настройка облака
    private func setupCloud() {
        
        let cloudFrame = CGRect(origin: CGPoint(x: randomXCoordinate,
                                                y: -cloud.sizeCloud.height),
                                size: cloud.sizeCloud)
        cloud = Cloud(frame: cloudFrame)
        cloud.image = UIImage(named: ImageName.cloud.rawValue)
        view.addSubview(cloud)
        cloud.cloudAnimate(self.view, randomCoordinate: randomXCoordinate)
    }
    
    //MARK: - Настройка НЛО
    private func setupUfo() {
        let ufoFrame = CGRect(origin: CGPoint(x: randomXCoordinate,
                                              y: 0),
                              size: sizeUfo)
        ufoImage = UIImageView(frame: ufoFrame)
        ufoImage.image = UIImage(named: ufoArray.randomElement()!)
        view.addSubview(ufoImage)
        ufoAnimate()
    }
    
    private func ufoAnimate() {
        animator = .runningPropertyAnimator(withDuration: speedGame,
                                            delay: 0,
                                            options: [.curveLinear],
                                            animations: { [self] in
            ufoImage.frame.origin.y += view.bounds.height
        },
                                            completion: { [self] _ in
            score += 1
            scoreCounter.text = String(score)
            ufoImage.frame.origin.x = randomXCoordinate
            ufoImage.frame.origin.y = 0
            ufoImage.image = UIImage(named: ufoArray.randomElement()!)
            ufoAnimate()
        })
        animator.startAnimation()
    }
    //MARK: - Настройка самолета
    
    private func setupAircraft() {
        let airY = view.bounds.height - aircraft.sizeAircraft.height * 2
        
        let frameImage = CGRect(origin: CGPoint(x: view.bounds.width / 2 - aircraft.sizeAircraft.width / 2,
                                                y: airY - aircraft.sizeAircraft.height),
                                size: aircraft.sizeAircraft)
        aircraft = Aircraft(frame: frameImage)
        aircraft.image = UIImage(named: ImageName.firstAircraft.rawValue)
        aircraft.aircraftCenter = aircraft.center
        view.addSubview(aircraft)
    }
    //MARK: - Настройка счетчика очков
    
    private func setupScoreCounter() {
        
        let frameScoreCounter = CGRect(x: view.bounds.width / 2 - sizeScoreCounter.width / 2,
                                       y: view.bounds.height - sizeScoreCounter.height,
                                       width: sizeScoreCounter.width,
                                       height: sizeScoreCounter.height)
        scoreCounter = UILabel(frame: frameScoreCounter)
        scoreCounter.textColor = .red
        scoreCounter.textAlignment = .center
        scoreCounter.text = "0"
        scoreCounter.font = UIFont(name: ImageName.labelGameStyle.rawValue,
                                   size: SizeElement.labelFont.rawValue)
        view.addSubview(scoreCounter)
    }
    
    //MARK: - Target
    
    @objc func tap(sender: UIPanGestureRecognizer) {
        let fileView = sender.view!
        
        switch sender.state {
        case .began, .changed:
            moveViewPan(view: fileView,
                        sender: sender)
        default:
            return
        }
    }
    
    @objc private func pauseGame() {
        customAlert.pauseAlert(self, animation: animator)
    }
    
    //MARK: - Проверка пересечения истребителя с НЛО
    @objc func ufoIntersects() {
        
        let dynamicUfoFrame = ufoImage.layer.presentation()?.frame
        let cloudFrame = cloud.layer.presentation()?.frame
        let ufoFrameArray = [dynamicUfoFrame]
        let cloudArrayFrame = [cloudFrame]
        for cloud in cloudArrayFrame {
            guard let cloud = cloud else { return }
            if aircraft.frame.intersects(cloud) {
                score += self.cloud.cloudScore
                scoreCounter.text = String(score)
            }
        }
        for ufo in ufoFrameArray {
            guard let ufo = ufo else { return }
            if aircraft.frame.intersects(ufo) {
                aircraft.image = UIImage(named:ImageName.explosion.rawValue)
                animator.stopAnimation(true)
                ufoImage.removeFromSuperview()
                timer.invalidate()
                
                Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { [self] _ in
                    aircraft.removeFromSuperview()
                    customAlert.gameOverAlert(self, score: score, result: resultScoreArray)
                }
            }
        }
    }
}
