//
//  RecordsViewController.swift
//  AliensInvasion
//
//  Created by Борис Кравченко on 05.09.2023.
//

import UIKit

final class RecordsViewController: UIViewController {
    
    //MARK: - Константы
    
    var heightCell: CGFloat = 50
    
    private enum TextLabel {
        static let recordsText: String = "Results table"
    }
    
    let titleLabel: UILabel = {
       var label = UILabel()
        label.text = TextLabel.recordsText
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue, size: SizeElement.labelFont.rawValue)
        label.textColor = .orange
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var tableView: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .black
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseId)
        return table
    }()
    
    var recordsArray: [Int] = []
    var nameArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupConstraint()
        setupNavigation()
        backgroundTableView()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        loadRecords()
    }
    
    @objc func resetRecord() {
        recordsArray.removeAll()
        tableView.reloadData()
        UserDefaults.standard.set(recordsArray, forKey: Keys.recordKey.rawValue)
    }
    
    private func setupNavigation() {
        navigationController?.hidesBarsOnSwipe = true
        let add = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetRecord))
        navigationItem.rightBarButtonItems = [add]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemOrange]
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.barTintColor = .clear
        
    }
    //MARK: - Настройка background TableView
    private func backgroundTableView() {
        let image = UIImage(named: ImageName.background.rawValue)
            let imageView = UIImageView(image: image)
            tableView.backgroundView = imageView
    }
    //MARK: - Загрузка и сортировка рекордов
    private func loadRecords() {
        let records = UserDefaults.standard.object(forKey: Keys.recordKey.rawValue) as? [Int]
        guard let records = records else { return }
        recordsArray = records
        recordsArray.sort(by: {$0 > $1})
    }

    //MARK: - Сonstraints
    private func setupConstraint() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension RecordsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
        //recordsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseId, for: indexPath) as! CustomTableViewCell
        cell.backgroundColor = .clear
        let post = recordsArray[indexPath.row]
        cell.configure(with: "\(post)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }
}
