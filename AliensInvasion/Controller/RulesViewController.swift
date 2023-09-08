//
//  RulesViewController.swift
//  AliensInvasion
//
//  Created by Борис Кравченко on 05.09.2023.
//

import UIKit

final class RulesViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(red: 0/255, green: 9/255, blue: 66/255, alpha: 1.0)
        return view
    }()
    
    private let articleText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Rules"
        return label
    }()
    
    private let descriptionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.tintColor = .systemGray5
        label.text = "🌍 В далёком будущем Земля была атакована инопланетным врагом, известным как rсеноморфы. Они использовали свои технологии, чтобы проникнуть на Землю и захватить её. Однако нашёлся герой, который решил встать на защиту своей планеты. Он собрал команду из других выживших людей и отправился в космос, чтобы найти способ победить пришельцев.\n\n🚀 Наш герой управляет космическим кораблём и должен уничтожать врагов, используя различное оружие на борту корабля. Цель игрока — защитить Землю от нашествия пришельцев и спасти человечество.\n\n📕 Правила: уворачивайся от столкновений с кораблями пришельцев, получай по 5 очков за каждый манёвр. Облака звёзной пыли - наши помощники - они помогают нам скрываться от пришельцев, за каждый пролёт сквозь них получай 30 очков.\n\n🔴 Чтобы поставить паузу или выйти из игры - нажми на результат с твоими очками внизу экрана."
        return label
    }()
    
    private let sloganText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "УДАЧИ, ГЕРОЙ!\nДА ПРЕБУДЕТ С ТОБОЙ СИЛА!\n\n\n\n\n"
        return label
    }()

    
    override func viewDidLoad() {
            super.viewDidLoad()
            layout()
    }
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(articleText)
        contentView.addSubview(descriptionText)
        contentView.addSubview(sloganText)
        
        let inset: CGFloat = 16
        let height: CGFloat = 24
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            articleText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            articleText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            articleText.heightAnchor.constraint(equalToConstant: height),
            articleText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            articleText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
   
            descriptionText.topAnchor.constraint(equalTo: articleText.bottomAnchor, constant: inset),
            descriptionText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            descriptionText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            sloganText.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: inset),
            sloganText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            sloganText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            sloganText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}

