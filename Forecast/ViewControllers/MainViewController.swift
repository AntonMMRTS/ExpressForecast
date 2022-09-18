//
//  ViewController.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import UIKit
import Swinject

class MainViewController: UIViewController, MainViewProtocol {

    // MARK: - MainViewProtocol
    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "sfsdfsf"
        view.backgroundColor = .white
    }


}

