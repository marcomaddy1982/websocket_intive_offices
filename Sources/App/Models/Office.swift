//
//  Office.swift
//  App
//
//  Created by Viktor Nakyden on 25.07.19.
//

import Foundation

struct Office: Codable {
    let locationId: LocationID
    let city: String
    let address: String
    let lat: String
    let long: String
    let phone: String

    static func mock(for locationId: LocationID) -> Office {

        switch locationId {
        case .ber:
            return  Office(
                locationId: .ber,
                city: "Berlin",
                address: "Boxhagener Str. 82, 10245 Berlin",
                lat: "52.508550",
                long: "13.466620",
                phone: "+49 941 569 590 0"
            )
        case .muc:
            return  Office(
                locationId: .muc,
                city: "Munich",
                address: "Neumarkter Str. 61, 81673 Munich",
                lat: "48.132780",
                long: "11.624330",
                phone: "+49 941 569 590 0"
            )
        case .reg:
            return  Office(
                locationId: .reg,
                city: "Regensburg",
                address: "Prinz-Ludwig-Str. 17, 93055 Regensburg",
                lat: "49.016490",
                long: "12.121630",
                phone: "+49 941 569 590 0"
            )
        }

    }
}
