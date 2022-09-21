//
//  SearchInteractorProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import Foundation

protocol SearchInteractorProtocol: AnyObject {
    var presenter: SearchPresenterInteractionProtocol! { get }
    
    func searchCity(text: String)
    func addCityToDatabase(city: City)
}
