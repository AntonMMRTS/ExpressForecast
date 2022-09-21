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
    
    var cities: [City] { get }
    
    func configureView()
    func backToMainScreen()
    func searchCity(text: String)
    func addCityToDatabase(city: City)
    func searchTextFieldDidChange(text: String)
}

protocol SearchPresenterInteractionProtocol: AnyObject {
    func succeccedFetchCurrentWeather(response: City)
    func failureRequest()
}
