//
//  MainViewProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol! { get set }
    
    func configureView()
    func updateView()
}
