//
//  CustomTableViewCell.swift
//  AliensInvasion
//
//  Created by Борис Кравченко on 05.09.2023.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    static var reuseId = "CustomTableViewCell"
    
    let recordLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ImageName.labelGameStyle.rawValue, size: SizeElement.labelFont.rawValue)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with title: String) {
        recordLabel.text = title
    }
    
    func setupConstraints() {
        
        addSubview(recordLabel)
        
        NSLayoutConstraint.activate([
            
            recordLabel.topAnchor.constraint(equalTo: self.topAnchor),
            recordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            recordLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            recordLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
