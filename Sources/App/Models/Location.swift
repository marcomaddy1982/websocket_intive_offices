//
//  Location.swift
//  App
//
//  Created by Viktor Nakyden on 25.07.19.
//

import Foundation

enum LocationID: String, Codable {
    case muc = "MUC"
    case ber = "BER"
    case reg = "REG"
}

struct Location: Codable {
    let id: LocationID
    let city: String
    let offices: [Office]
    let imageUrl: String

    static var mocks: [Location] {
        return [
            Location(id: .muc, city: "Munich", offices: [], imageUrl: "https://munichnow.com/wp-content/uploads/2017/03/59628-17082366_304.jpg"),
            Location(id: .ber, city: "Berlin", offices: [], imageUrl: "https://www.tripzaza.com/ru/destinations/files/2017/09/Berlin-e1505798693967.jpg"),
            Location(id: .reg, city: "Regensburg", offices: [], imageUrl: "https://www.dw.com/image/16946292_303.jpg")
        ]
    }

    static var mock: Location {
        return  Location(id: .muc, city: "Munich", offices: [], imageUrl: "https://munichnow.com/wp-content/uploads/2017/03/59628-17082366_304.jpg")
    }
}
