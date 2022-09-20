//
//  SearchConfiguratorProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import Foundation

protocol SearchConfiguratorProtocol {
    func configure(viewController: SearchViewController, delegate: SearchDelegate)
}
