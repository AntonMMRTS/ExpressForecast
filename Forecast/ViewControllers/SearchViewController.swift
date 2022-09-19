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
    
    // MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        presenter.configureView()
    }
    
    // MARK: - MainViewProtocol Methods
    func configureView() {
        title = "sfsdfsf"
        view.backgroundColor = .red
    }
}
