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

