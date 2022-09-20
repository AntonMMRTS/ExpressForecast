//
//  SearchViewProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    var presenter: SearchPresenterProtocol! { get set }
    
    func configureView()
    func updateView()
}
