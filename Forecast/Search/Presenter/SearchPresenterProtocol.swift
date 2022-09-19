//
//  SearchPresenterProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    var view: SearchViewProtocol! { get }
    var router: SearchRouterProtocol! { get }
    var interactor: SearchInteractorProtocol! { get }
    
    
    func configureView()
    func backToMainScreen()
}

protocol SearchPresenterInteractionProtocol: AnyObject {
//    func succeccedFetchCurrentWeather(response: Weather)
}
