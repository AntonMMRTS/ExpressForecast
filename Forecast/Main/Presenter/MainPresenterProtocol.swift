//
//  MainPresenterProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol! { get }
    var router: MainRouterProtocol! { get }
    var interactor: MainInteractorProtocol! { get }
    
    func configureView() 
}

protocol MainPresenterInteractionProtocol: AnyObject {
    
}