//
//  SearchViewController.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import UIKit

class SearchViewController: UIViewController, SearchViewProtocol {
    
    // MARK: - MainViewProtocol Properties
    var presenter: SearchPresenterProtocol!
    
    // MARK: - Private Properties
    private let searchView: UIView = {
        let searchView = UIView()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.backgroundColor = .white
        searchView.layer.cornerRadius = 12
        searchView.clipsToBounds = true
        return searchView
    }()
    
    let backButton: UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: "backIcon"), for: .normal)
        return backButton
    }()
    
    let searchTextfield: UITextField = {
        let searchTextfield = UITextField()
//        searchTextfield.textColor = .darkPrimary
        searchTextfield.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        searchTextfield.autocapitalizationType = .words
        searchTextfield.backgroundColor = .white
        searchTextfield.clearButtonMode = .always
        searchTextfield.translatesAutoresizingMaskIntoConstraints = false
        return searchTextfield
    }()
    
    // MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        presenter.configureView()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        navigationItemSettings()
//    }
    
    // MARK: - MainViewProtocol Methods
    func configureView() {
        title = "sfsdfsf"
        view.backgroundColor = .red
        configure()
    }
    
    // MARK: - Private Methods
    private func configure() {
        searchView.addSubview(backButton)
        searchView.addSubview(searchTextfield)
        view.addSubview(searchView)
        
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 44),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            backButton.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            
            searchTextfield.leadingAnchor.constraint(equalTo: backButton.trailingAnchor),
            searchTextfield.trailingAnchor.constraint(equalTo: searchView.trailingAnchor),
            searchTextfield.topAnchor.constraint(equalTo: searchView.topAnchor),
            searchTextfield.bottomAnchor.constraint(equalTo: searchView.bottomAnchor),
            
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        navigationItemSettings()
    }
    
    private func navigationItemSettings() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    @objc
    private func backButtonDidTap() {
        presenter.backToMainScreen()
    }
}
