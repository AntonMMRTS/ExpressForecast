//
//  MainRouterProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation

protocol MainRouterProtocol: AnyObject {
    
    func pushSearchScreen(delegate: SearchDelegate)
    func presentAlert(title: String) 
}
