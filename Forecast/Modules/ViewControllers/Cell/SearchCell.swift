//
//  SearchCell.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import UIKit

final class SearchCell: UITableViewCell {
    
    static let identifier = "SearchCell"
    
    var completion: (() -> Void)?
    
    private let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.textColor = .black
        cityLabel.font = .helveticaNeueMedium23
        cityLabel.textAlignment = .left
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    private let actionButton: UIButton = {
        let actionButton = UIButton()
        actionButton.setImage(UIImage.addIcon, for: .normal)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        return actionButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    func configure(city: City, completion: (() -> Void)? = nil) {
        cityLabel.text = city.name
        
        self.completion = completion
        actionButton.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
    }
    
    private func configureView() {
        contentView.addSubview(actionButton)
        contentView.addSubview(cityLabel)
        
        self.backgroundColor = .white
        self.selectionStyle = .none

        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cityLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -16),
            cityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 24),
            actionButton.heightAnchor.constraint(equalToConstant: 24),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    @objc
    func actionButtonDidTap() {
        completion?()
    }
}

