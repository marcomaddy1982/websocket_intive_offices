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

    var offices: [Office] {
        return Office.mock(for: self)
    }

    var officesNumber: Int {
        return offices.count
    }
}

struct Location: Codable {
    let id: LocationID
    let city: String
    let officesNumber: Int
    let imageUrl: String

    static var mocks: [Location] {
        let reg: LocationID = .reg
        let muc: LocationID = .muc
        let ber: LocationID = .ber
        return [
            Location(id: muc, city: "Munich", officesNumber: muc.officesNumber, imageUrl: "https://munichnow.com/wp-content/uploads/2017/03/59628-17082366_304.jpg"),
            Location(id: ber, city: "Berlin", officesNumber: ber.officesNumber, imageUrl: "https://www.tripzaza.com/ru/destinations/files/2017/09/Berlin-e1505798693967.jpg"),
            Location(id: reg, city: "Regensburg", officesNumber: reg.officesNumber, imageUrl: "https://www.dw.com/image/16946292_303.jpg")
        ]
    }

    static var mock: Location {
        let muc: LocationID = .muc
        return  Location(id: muc, city: "Munich", officesNumber: muc.officesNumber, imageUrl: "https://munichnow.com/wp-content/uploads/2017/03/59628-17082366_304.jpg")
    }
}
