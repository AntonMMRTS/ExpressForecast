//
//  ViewController.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import UIKit
import Swinject

class MainViewController: UIViewController, MainViewProtocol {

    // MARK: - MainViewProtocol Properties
    var presenter: MainPresenterProtocol!
    
    // MARK: - Private Properties
    private var citiesCollectionView: UICollectionView!
    
    // MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        presenter.configureView()
    }

    // MARK: - MainViewProtocol Methods
    func configureView() {
        title = "sfsdfsf"
        view.backgroundColor = .red
        configureCollectionView()
    }
    
    // MARK: - Private Methods
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        citiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        citiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        citiesCollectionView.backgroundColor = .black
        citiesCollectionView.register(MainCell.self,
                                        forCellWithReuseIdentifier: MainCell.identifier)
        
        citiesCollectionView.delegate = self
        citiesCollectionView.dataSource = self
        
        autolayoutSetup()
    }
    
    private func autolayoutSetup() {
        guard let citiesCollectionView = citiesCollectionView else { return }
        
        view.addSubview(citiesCollectionView)
        
        NSLayoutConstraint.activate([
            citiesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            citiesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            citiesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            citiesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        presenter.cities.count
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as! MainCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

