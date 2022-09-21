//
//  City.swift
//  Forecast
//
//  Created by Антон Усов on 21.09.2022.
//

import Foundation
import RealmSwift

final class City: Object, Decodable {
    var weather = List<Description>()
    @objc dynamic var main: Main? = Main()
    @objc dynamic var name: String = ""
}

final class Main: Object, Decodable {
    @objc dynamic var temp: Double = 0
    @objc dynamic var pressure: Int = 0
    @objc dynamic var humidity: Int = 0
}

final class Description: Object, Decodable {
    @objc dynamic var main: String = ""
    @objc dynamic var id: Int = 0
}

extension RealmSwift.List: Decodable where Element: Decodable {
    public convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.singleValueContainer()
        let decodedElements = try container.decode([Element].self)
        self.append(objectsIn: decodedElements)
    }
}
