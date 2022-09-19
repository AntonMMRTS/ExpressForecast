//
//  MainCell.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import UIKit

class MainCell: UICollectionViewCell {
    static let identifier = "MainCell"
    
    let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.textColor = .white
        cityLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 23)
        cityLabel.textAlignment = .center
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.text = "dgfdfgsdfgsdfgfdgfg"
        return cityLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(cityLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        autolayoutSetup()
    }
    
    private func autolayoutSetup() {
        contentView.backgroundColor = .orange
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
