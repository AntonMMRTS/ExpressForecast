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
    
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: "backIcon"), for: .normal)
        return backButton
    }()
    
    private let searchTextfield: UITextField = {
        let searchTextfield = UITextField()
        searchTextfield.returnKeyType = .search
        searchTextfield.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        searchTextfield.autocapitalizationType = .words
        searchTextfield.backgroundColor = .white
        searchTextfield.textColor = .black
        searchTextfield.clearButtonMode = .always
        searchTextfield.translatesAutoresizingMaskIntoConstraints = false
        return searchTextfield
    }()
    
    private let citiesTableView: UITableView = {
        let citiesTableView = UITableView()
        citiesTableView.translatesAutoresizingMaskIntoConstraints = false
        citiesTableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        return citiesTableView
    }()
    
    // MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .systemGray5
        presenter.configureView()
    }
    
    // MARK: - MainViewProtocol Methods
    func configureView() {
        searchTextfield.delegate = self
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        searchTextfield.becomeFirstResponder()
        initializeHideKeyboard()
        configure()
    }
    
    func updateView() {
        citiesTableView.reloadData()
    }
    
    // MARK: - Private Methods
    private func configure() {
        searchView.addSubview(backButton)
        searchView.addSubview(searchTextfield)
        view.addSubview(searchView)
        view.addSubview(citiesTableView)
        
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
            searchView.heightAnchor.constraint(equalToConstant: 44),
            
            citiesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            citiesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            citiesTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 8),
            citiesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        searchTextfield.addTarget(self, action: #selector(searchTextfieldChanged), for: .editingChanged)
        navigationItemSettings()
    }
    
    private func navigationItemSettings() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    @objc
    private func searchTextfieldChanged(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty else { return }
        presenter.searchTextFieldDidChange(text: text)
    }
    
    @objc
    private func backButtonDidTap() {
        presenter.backToMainScreen()
    }
    
    private func initializeHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func searchButtonDidTap() {
        guard let text = searchTextfield.text, text.count > 2 else { return }
        
        presenter.searchCity(text: text)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        searchButtonDidTap()
        return false
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = presenter.cities[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        cell.configure(city: city) {
            self.presenter.addCityToDatabase(city: city)
        }
        return cell
    }
}

