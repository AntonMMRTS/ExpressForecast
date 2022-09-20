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
        cityLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 42)
        cityLabel.textAlignment = .center
        cityLabel.numberOfLines = 0
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 100)
        temperatureLabel.textAlignment = .center
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureLabel
    }()
    
    let pressureLabel: UILabel = {
        let pressureLabel = UILabel()
        pressureLabel.textColor = .white
        pressureLabel.text = "Давление:"
        pressureLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 23)
        pressureLabel.textAlignment = .center
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        return pressureLabel
    }()
    
    let pressureLabelValue: UILabel = {
        let pressureLabelValue = UILabel()
        pressureLabelValue.textColor = .white
        pressureLabelValue.font = UIFont(name: "HelveticaNeue-Medium", size: 23)
        pressureLabelValue.textAlignment = .center
        pressureLabelValue.translatesAutoresizingMaskIntoConstraints = false
        return pressureLabelValue
    }()
    
    let humidityLabel: UILabel = {
        let humidityLabel = UILabel()
        humidityLabel.textColor = .white
        humidityLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 23)
        humidityLabel.text = "Влажность:"
        humidityLabel.textAlignment = .center
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        return humidityLabel
    }()
    
    let humidityLabelValue: UILabel = {
        let humidityLabelValue = UILabel()
        humidityLabelValue.textColor = .white
        humidityLabelValue.font = UIFont(name: "HelveticaNeue-Medium", size: 23)
        humidityLabelValue.textAlignment = .center
        humidityLabelValue.translatesAutoresizingMaskIntoConstraints = false
        return humidityLabelValue
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clear")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(cityLabel)
        contentView.addSubview(temperatureLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        autolayoutSetup()
    }
    
    func configure(city: Weather) {
        cityLabel.text = city.name
        
        guard let main = city.main else { return }
        configureImageView(id: city.weather.first?.id)
        let degrees = Int(main.temp) - 273
        temperatureLabel.text = "\(degrees)°C"
        humidityLabelValue.text = "\(main.humidity)%"
        pressureLabelValue.text = "\(main.pressure) гПа"
    }
    
    private func configureImageView(id: Int?) {
        guard let id = id else {
            imageView.image = UIImage(named: "clear")
            return }
        
        if (0..<501).contains(id) {
            imageView.image = UIImage(named: "rain")
        } else if id > 801 {
            imageView.image = UIImage(named: "cloud")
        } else {
            imageView.image = UIImage(named: "clear")
        }
    }
    
    private func autolayoutSetup() {
        
        let pressureView = UIView()
        pressureView.translatesAutoresizingMaskIntoConstraints = false
        pressureView.addSubview(pressureLabel)
        pressureView.addSubview(pressureLabelValue)

        let humidityView = UIView()
        humidityView.translatesAutoresizingMaskIntoConstraints = false
        humidityView.addSubview(humidityLabel)
        humidityView.addSubview(humidityLabelValue)
        
        let stack = UIStackView(arrangedSubviews: [pressureView, humidityView])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            
            cityLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            stack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            stack.heightAnchor.constraint(equalToConstant: 90),
            stack.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: cityLabel.topAnchor, constant: -30),
            
            pressureLabel.leadingAnchor.constraint(equalTo: pressureView.leadingAnchor, constant: 10),
            pressureLabel.trailingAnchor.constraint(equalTo: pressureView.trailingAnchor, constant: -10),
            pressureLabel.centerXAnchor.constraint(equalTo: pressureView.centerXAnchor),
            pressureLabel.centerYAnchor.constraint(equalTo: pressureView.centerYAnchor),

            pressureLabelValue.leadingAnchor.constraint(equalTo: pressureView.leadingAnchor, constant: 10),
            pressureLabelValue.trailingAnchor.constraint(equalTo: pressureView.trailingAnchor, constant: -10),
            pressureLabelValue.centerXAnchor.constraint(equalTo: pressureLabel.centerXAnchor),
            pressureLabelValue.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: 10),
            
            humidityLabel.leadingAnchor.constraint(equalTo: humidityView.leadingAnchor, constant: 10),
            humidityLabel.trailingAnchor.constraint(equalTo: humidityView.trailingAnchor, constant: -10),
            humidityLabel.centerXAnchor.constraint(equalTo: humidityView.centerXAnchor),
            humidityLabel.centerYAnchor.constraint(equalTo: humidityView.centerYAnchor),

            humidityLabelValue.leadingAnchor.constraint(equalTo: humidityView.leadingAnchor, constant: 10),
            humidityLabelValue.trailingAnchor.constraint(equalTo: humidityView.trailingAnchor, constant: -10),
            humidityLabelValue.centerXAnchor.constraint(equalTo: humidityLabel.centerXAnchor),
            humidityLabelValue.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 10),
        ])
    }
}
